From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: tasklet (AudioScience)
Date: Tue, 27 May 2003 21:37:23 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030527213724.5915.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 19 May 2003 at 18:34, Takashi Iwai wrote:

> > Our cards have no interrupts, and no DMA (...yet. The next one
> > probably will) so they must be polled.
> 
> hmm, no interrupts at all?
> 
> > Based on the dummy driver, I am using a timer to do the polling. So
> > far, it does play audio, but often crashes or locks the machine
> > solid with a kernel panic.
> 
> perhaps the interrupt takes too long time?
> for a pseudo-DMA transfer, tasklet may be a better choice.

Takashi, can you expand on this?  Is there an example of a tasklet being used
for pseudo DMA?   I'm afraid I don't know enough to write code based on your
brief suggestions.

thanks

Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
