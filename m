From: Anders Torger <torger@ludd.luth.se>
Subject: Re: 192khz working for anyone?  and  RME96 patch broke
Date: Tue, 28 Jan 2003 08:14:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301280814.59709.torger@ludd.luth.se>
References: <200301280527.h0S5RYn81413@mail.mega.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301280527.h0S5RYn81413@mail.mega.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Pouzzner <douzzer@mega.nu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 28 January 2003 06.27, Daniel Pouzzner wrote:
> First the RME thing: Torger's post-RC6 patch to rme96.c broke
> double-speed capture, so that there is nasty clipping/Nyquist-type
> garbage in it.  This is definitely in the patch itself - a CVS kernel
> with an RC6 rme96.c works fine.

Strange, I did not touch that code specifically. Anyway, so you have 
tested with an old ALSA and the new driver (rme96.c) and that does not 
work?

Is it double speed capture from analog, or from digital input you are 
having problems with?

/Anders Torger


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
