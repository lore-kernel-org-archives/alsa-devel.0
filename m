From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Trigger Callback
Date: Tue, 01 Aug 2006 15:55:19 -0400
Message-ID: <1154462119.14540.73.camel@mindpipe>
References: <44CFB014.2050704@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44CFB014.2050704@blueyonder.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Julien Bramary <julien.bramary@blueyonder.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-08-01 at 20:48 +0100, Julien Bramary wrote:
> I'm an Alsa beginner and I'm trying to write an alsa driver for an embedded dac on ARM.
> 
> >From Iwai's doc:
> 
> /* trigger callback */
> static int snd_mychip_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> {
>     switch (cmd) {
>     case SNDRV_PCM_TRIGGER_START:
>             // do something to start the PCM engine
>             break;
>     case SNDRV_PCM_TRIGGER_STOP:
>             // do something to stop the PCM engine
>             break;
>     default:
>             return -EINVAL;
>     }
> }
> 
> My question here is,
> What are we supposed to do to start the PCM engine?
> Because, I'm currently doing nothing, and yet it starts anyway...
> I'd like to understand to have more control.

"PCM engine" refers to the hardware's PCM engine, not ALSA's.  It's 100%
device dependent - you need to consult the docs for your sound device to
determine how to start the PCM.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
