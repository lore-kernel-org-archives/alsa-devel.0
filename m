From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Single process freeze when opening capture device
Date: Thu, 29 May 2003 16:05:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305291603300.28435-100000@pnote.perex-int.cz>
References: <3ED60FD4.3010801@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ED60FD4.3010801@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Arthur Peters <amp@singingwizard.org>, Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 May 2003, James Courtier-Dutton wrote:

> Jaroslav Kysela wrote:
> > 
> > 
> > It is limit of current alsa-lib configuration. We cannot distinct playback
> > and capture. But I am not sure, if returning an error helps you
> > (surround40 configuration is NOT valid for emu10k1). I suggest to fix jack
> > to allow different names for playback and capture with different count of
> > channels.
> > 
> > 						Jaroslav
> > 
> Surround40 playback seems to work on my SB Live emu10k1.
> Some SB Live cards have 2 stereo audio inputs, so in theory they should 
> be able to do Surround40 capture as well.
> Can the SB Live do 4 channel full duplex, or is there another factor 
> involved.

The multichannel capture must be implemented using the FX DSP code (like 
raw S/PDIF). The standard capture device for emu10k1 can handle only 
stereo stream.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
