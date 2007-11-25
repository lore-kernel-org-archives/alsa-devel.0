From: Tim <terminator356@users.sourceforge.net>
Subject: Re: multi pcm and mmap problem
Date: Sun, 25 Nov 2007 17:51:04 -0500
Message-ID: <200711251751.05205.terminator356@users.sourceforge.net>
References: <200711210158.42108.terminator356@users.sourceforge.net>
	<200711232031.03910.terminator356@users.sourceforge.net>
	<s5hr6igne2h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.rog.mail.re2.yahoo.com (smtp107.rog.mail.re2.yahoo.com
	[68.142.225.205]) by alsa0.perex.cz (Postfix) with SMTP id 2C67D24636
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 23:37:00 +0100 (CET)
In-Reply-To: <s5hr6igne2h.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 24 November 2007 05:16:38 am you wrote:
> At Fri, 23 Nov 2007 20:31:03 -0500,
> Tim wrote:
> > A final 'note':
> > The envy24control app's Master Clock - Signal/No Signal
> >  seems broken again.
> > I know the cards are locked, but it still says 'No signal'
> >  when S/PDIF is selected.
> Hm, could you check whether it's a driver bug or a bug of
> envy24control?  This control can be basically also get/set via
> alsactl.  For example, just run "alsactl -f somefile store", edit the
> file, and "alsactl -f somefile restore".  Also, you can set the value
> via amixer, too.

Pardon my previous enthusiasm. So many months debugging!
I've straightened my tie and regained my composure now. 

I tried creating a new asound.state with alsactl.
The resulting asound.state was smaller, but did not fix the problem.
I also tried manually turning the 'IEC958 CS8427 Error Status', and the 
 other related controls, on/off with a mixer, no luck.
 
I know the two cards are locked because if I disconnect the S/PDIF cable,
 the ice1712 card goes silent or makes noises. This is normal behaviour.
Also, I have run this setup for hours without an xrun or 'un-synced drifting'.

You know, the 'locked/no signal' indicator never has worked right.
In ALSA 1.0.9b it always just says 'locked' (see below).
In ALSA 1.0.15 it says 'locked' only when on a fixed internal rate.

** Here is some info below which I think will help.

It seems to me, looking at the 'IEC958 CS8427 Error Status' results below,
 that envy24control should perhaps be using it, instead of 
 'Word Clock Status', as a 'locked' indicator.
 
Thanks again. Tim.
 
----------------------------------------------------------
ALSA 1.0.15 + new distro:
----------------------------------------------------------
Master Clock says 'No signal'.
Master Clock: S/PDIF. S/PDIF cable is connected.
$ amixer -c1 contents
...
numid=65,iface=MIXER,name='Word Clock Status'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=64,iface=MIXER,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=32
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=15


Master Clock says 'No signal'.
Master Clock: S/PDIF. S/PDIF cable is NOT connected.
$ amixer -c1 contents
...
numid=65,iface=MIXER,name='Word Clock Status'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=64,iface=MIXER,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=54
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=15


Master Clock says 'No signal'.
Master Clock: Word Clock. S/PDIF cable is connected.
$ amixer -c1 contents
...
numid=65,iface=MIXER,name='Word Clock Status'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=64,iface=MIXER,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=32
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=15


Master Clock says 'No signal'.
Master Clock: Word Clock. S/PDIF cable is NOT connected.
$ amixer -c1 contents
...
numid=65,iface=MIXER,name='Word Clock Status'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=64,iface=MIXER,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=54
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=15


Master Clock says 'Locked'.
Master Clock: 48000 Internal. S/PDIF cable is connected.
$ amixer -c1 contents
...
numid=65,iface=MIXER,name='Word Clock Status'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=64,iface=MIXER,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=0
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=67


Master Clock says 'Locked'.
Master Clock: 48000 Internal. S/PDIF cable is NOT connected.
$ amixer -c1 contents
...
numid=65,iface=MIXER,name='Word Clock Status'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=64,iface=MIXER,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=0
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r-------,values=1,min=0,max=255,step=0
  : values=67
  
  
  
----------------------------------------------------------
ALSA 1.0.9b + older distro:
----------------------------------------------------------
Master Clock says 'Locked' in all cases below...
Note: I could not find a 'Word Clock Status' item.
Perhaps that's why it never worked at all under ALSA 1.0.9b ?

Master Clock: S/PDIF. S/PDIF cable is connected.
$ amixer -c1 contents
...
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=0
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=67
numid=64,iface=PCM,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off

  
Master Clock: S/PDIF. S/PDIF cable is NOT connected.
$ amixer -c1 contents
...
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=63
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=67
numid=64,iface=PCM,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off

  
Master Clock: Word Clock. S/PDIF cable is connected.
$ amixer -c1 contents
...
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=0
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=67
numid=64,iface=PCM,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on

  
Master Clock: Word Clock. S/PDIF cable is NOT connected.
$ amixer -c1 contents
...
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=23
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=67
numid=64,iface=PCM,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on

  
Master Clock: 48000 Internal. S/PDIF cable is connected.
$ amixer -c1 contents
...
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=31
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=67
numid=64,iface=PCM,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
  
  
Master Clock: 48000 Internal. S/PDIF cable is NOT connected.
$ amixer -c1 contents
...
numid=2,iface=PCM,name='IEC958 CS8427 Error Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=22
numid=1,iface=PCM,name='IEC958 CS8427 Input Status'
  ; type=INTEGER,access=r----,values=1,min=0,max=255,step=0
  : values=67
numid=64,iface=PCM,name='Word Clock Sync'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
