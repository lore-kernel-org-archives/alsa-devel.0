From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How to display mixer controls to the user? was:Re:
	[PATCH/RFC] emu10k1 multichannel PCM
Date: Sun, 14 Nov 2004 23:10:23 -0500
Message-ID: <1100491824.2417.4.camel@krustophenia.net>
References: <1100300857.19038.14.camel@krustophenia.net>
	 <1100405924.16103.23.camel@krustophenia.net>
	 <4197433E.80008@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4197433E.80008@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-11-14 at 11:36 +0000, James Courtier-Dutton wrote:
> > Here is a patch that adds the mixer controls for this device.  This
> > includes the previous patches (add multichannel support and add register
> > dump to /proc)  Unfortunately this adds 16 x 3 mixer controls... people
> > complain enough about the emu10k1 mixer already, so this might not be
> > well received in some circles.  I am not sure what to do about this.
> > The kX mixer probably has hundreds of controls, but they are arranged in
> > a tree structure.
> > 
> 
> I have similar problems with the mixer controls. If I add 
> p16v(24bit/96khz etc.) support to the emu10k1 driver, it will add a load 
> more controls. For example, the volume controls for the 96khz channel 
> are separate from the volume controls for emu10k1 48khz channels.
> Maybe we need to start discussing ways to separate out mixer controls 
> better.
> E.g.
> Global controls.
> Controls specific to a pcm device.
> Controls specific to a particular section of DSP code.

I don't think you need anything really fancy (for now), it would be
sufficient to be able to nest mixer controls.  This would be the
simplest possible change that would solve the problem.  You can have
hundreds of mixer controls if you like, you just display the 8-10 that
the user is most likely to want, then make them drill down to get the
rest.  For example all of the controls for my device would live under
"multichannel PCM" and for yours "P16" or "24/96 controls".

The flat mixer space has hit the limits of what it can do.  We are at
the point where improving the low level drivers requires something to be
done about it.

Lee

Lee  



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
