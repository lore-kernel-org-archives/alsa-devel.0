From: Edward Muller <edwardam@interlix.com>
Subject: Re: AW: (Still) Problems with VIA8233
Date: 11 Mar 2003 12:47:59 -0600
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1047408479.4763.48.camel@localhost.localdomain>
References: <NNEPIBGIJICIEADJOOIACEBOCDAA.phueper@proqrent.de>
	 <1047404456.4763.29.camel@localhost.localdomain>
	 <s5h4r693i0m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r693i0m.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pattrick Hueper - proQrent GmbH <phueper@proqrent.de>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

comments inline...

On Tue, 2003-03-11 at 11:55, Takashi Iwai wrote:
> At 11 Mar 2003 11:40:56 -0600,
> Edward Muller wrote:
> > 
> > I am currently running a cvs version of also from a week ago...Sometime
> > after rc8 IIRC.
> > 
> > Here are my problems:
> > 
> > -OSS emulation is pretty much broken. This is my biggest problem since a
> > lot of app (esound, the kde rpms I am using, realplayer, etc) use oss.
>  
> please elaborate (together with your system details) ?
> "doesn't work" is not a magic word to explain everything.

Very true. Currently any apps using an oss device loop continuously over
the first X seconds of the music. I really don't know how long X is,
probably the first 1 to 3 seconds. I usually end up having to kill the
software to get control back.

> 
> ALSA native apps are working?  if yes, then it must be a different
> reason from Pattrick's problem.

Lemme re-state that. I was under the impression that the only native
alsa application I had was XMMS w/xmms-alsa. I forgot about things like
aplay and the like. aplay also exhibits the same problems as the oss
apps above. But XMMS w/xmms-alsa work for the most part. See my previous
comments about skipping/faltering ... And I really need to test w/o
preempt.

> 
> > -When cpu usage spikes any playback sometimes gets a little wierd
> > (skipping, faltering, etc). This may be due to that fact that I am
> > running a preempt enabled kernel. I will take the time to re-compile a
> > non-preempt kernel (and rebuild alsa, win4lin, vmware, nvidia :-( )
> > later this week.
> 
> this may have been improved in the latest version.
> 
> 
> ciao,
> 
> Takashi
-- 
Edward Muller

Interlix - President

Web Hosting - PC Service & Support
Custom Programming - Network Service & Support

Phone: 417-862-0573
 Cell: 417-844-2435
  Fax: 417-862-0572

http://www.interlix.com



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
