From: Christoph Lameter <christoph@lameter.com>
Subject: Re: cmipci driver locking up linux hard
Date: Tue, 8 Aug 2006 17:14:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608081713040.2054@graphe.net>
References: <Pine.LNX.4.64.0608041616590.9917@graphe.net>
	<s5hy7u0raux.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608070927480.3308@graphe.net>
	<s5hhd0os9nv.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608071318580.7499@graphe.net>
	<s5hhd0nr2va.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhd0nr2va.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Aug 2006, Takashi Iwai wrote:

> I still don't get it right whether the problem is in the interrupt
> lockup or it hits some hardware things.  The fact that the lockup
> happens after playing mp3 sounds like the former, though.
> 
> Could you check the values of registers CM_REG_INT_STATUS and
> CM_REG_INT_HLDCLR in snd_cmipci_interrupt() by printk?

Ok. Output was

XXXX cmpci STAT=0x800000c1 INT=0xa010000

Was not able to use the system with this.
 
> Also, you can comment out the whole block of if (cm->pcm) { ... }
> in snd_cmipci_interrupt().  This will skip the processing of data,
> i.e. exclude the possibility in ALSA PCM core part.

Did that at the same time as adding the printk part. Will now take out the 
printk to see if it still works.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
