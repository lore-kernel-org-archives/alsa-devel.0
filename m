From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: IRQ trouble...[notices]
Date: Mon, 27 Jan 2003 15:37:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E35442C.3010809@kss-loka.si>
References: <3E32E87C.9000505@student.kuleuven.ac.be> <3E34D495.8050605@kss-loka.si> <3E34F410.5010400@student.kuleuven.ac.be> <3E3511F2.9070206@kss-loka.si> <3E353AC9.9000901@esat.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E353AC9.9000901@esat.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <ppalmers@esat.kuleuven.ac.be>
Cc: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pieter Palmers wrote:

> There is one remark though: Your driver oops at some times (null 
> pointer dereference), ie when doing: (sam_ucode.c)
>    err = snd_sam9407_init_command(NULL, bytes, 7, NULL, 0, -1);
>
> The problem is in the magic_cast:
> When calling this with queue=NULL, the magic_cast causes an oops, 
> which is pretty normal I guess. I wonder why it didn't in your tests.
>
> /* transmit init command sequence to sam9407 */
> int snd_sam9407_init_command(sam9407_io_queue_t * queue,
>                 u8 *cmd_buffer, int cmd_bytes,
>                 u8 *rcv_buffer, int rcv_bytes,
>                 int ack)
> {
>    sam9407_t *sam = snd_magic_cast(sam9407_t, queue->sam, return 
> -EINVAL);
>
>    signed long end_time;
>    int err;
>
>    unsigned long flags;
>
>    if (queue) {
> (...)


  Yikes! This is an unfinished ""cleanup"" stuff. I was trying to get 
rid all the queue setup overhead when command actually didn't expect any 
response (when ACK = -1). These commands should be called with:

/* transmit init command sequence to sam9407 */
int snd_sam9407_init_command(sam9407_t *sam,
                sam9407_io_queue_t * queue,
                u8 *cmd_buffer, int cmd_bytes,
                u8 *rcv_buffer, int rcv_bytes,
                int ack)

  (The same applies to snd_sam9407_command())

  Following this, calls to these two commands should be fixed to use 
*sam variable.  sam9407_t *sam should be removed from 
sam9407_io_queue_t. In snd_sam9407_queue_prepare() function, remove test 
for (ack >= 0) and allways use

        queue->error = -EIO;
        queue->ack = ack & 0xff;
        set_bit(SAM_QUEUE_WAIT_ACK, &queue->status);
        set_bit(SAM_QUEUE_BUSY, &queue->status);

codepath.

Commands without acknowledge should now be called with
snd_sam9407_[init_]command(sam, NULL, buffer,  num_cmd,  XXXX,  X, X);

where X doesn't matter.

    Uros.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
