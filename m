From: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 17:19:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200404121719.52103.daniel.ritz@gmx.ch>
References: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
Reply-To: daniel.ritz@gmx.ch
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
Content-Disposition: inline
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: 'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, 'Russell King' <rmk+lkml@arm.linux.org.uk>, alsa-devel@lists.sourceforge.net, 'Tim Blechmann' <TimBlechmann@gmx.net>, David Hinds <dhinds@sonic.net>
List-Id: alsa-devel@alsa-project.org

On Monday 12 April 2004 03:39, Ivica Ico Bukvic wrote: 
> **I've noted that when I use:
> 
> setpci -s a.0 0x81.b
> 
> after changing the value to 0xd0 (with setpci -s a.0 0x81.b=d0) it would
> tell me that it was equal to f0, yet the "hexdump -v /proc/bus/pci/00/0a.0"
> would tell me it was d0 after all (see the log below).
> 

it's a single bit change from 0xd0 to 0xf0. it's bit 13 of the system control
register at 0x80. it's the socket activity bit that is read-clear. this means
writing to it has no effect, reading it clears the content. so the behavior
is normal...
