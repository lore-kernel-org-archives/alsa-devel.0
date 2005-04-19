From: Glenn Maynard <glenn@zewt.org>
Subject: Re: HW mix
Date: Tue, 19 Apr 2005 02:06:47 -0400
Message-ID: <20050419060647.GG6018@zewt.org>
References: <Pine.HPX.4.33n.0504181156540.10408-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.58.0504181206180.1759@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504181206180.1759@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 18, 2005 at 12:06:54PM +0200, Jaroslav Kysela wrote:
> On Mon, 18 Apr 2005, Clemens Ladisch wrote:
> 
> > Dino wrote:
> > >    i want to mix some pcm streams using hardware (where possible). One process
> > > with some thread witch want to play with one device (hw:0,0). Actually i simply
> > > open the device as it can (32 at max for me) with snd_pcm_open() and hw:0,0 as
> > > the device. It's seems to work but i don't know if it's the rigth way.
> > 
> > "hw:0,0" will fail if another program has already opened it.
> > Use "hw:0" which instructs ALSA to open the first available subdevice.
> 
> Nope, hw:0,0 is correct (CARD,DEVICE). You meant probably hw:0,0,0 
> (CARD,DEVICE,SUBDEVICE).

Is there anything wrong with using "hw:0" instead of "hw:0,0", or are they
equivalent?  It's what I've always used, without issue.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
