From: James Courtier-Dutton <James@superbug.co.uk>
Subject: How to display mixer controls to the user? was:Re: [PATCH/RFC]
 emu10k1 multichannel PCM
Date: Sun, 14 Nov 2004 11:36:30 +0000
Message-ID: <4197433E.80008@superbug.co.uk>
References: <1100300857.19038.14.camel@krustophenia.net> <1100405924.16103.23.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100405924.16103.23.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Fri, 2004-11-12 at 18:07 -0500, Lee Revell wrote:
> 
>>This patch is still missing a few things, like dynamic voice allocation
>>and correctly setting the send routing, but it does work with JACK, and
>>should not interfere with the operation of the other devices.   I tested
>>it like so:
> 
> 
> Here is a patch that adds the mixer controls for this device.  This
> includes the previous patches (add multichannel support and add register
> dump to /proc)  Unfortunately this adds 16 x 3 mixer controls... people
> complain enough about the emu10k1 mixer already, so this might not be
> well received in some circles.  I am not sure what to do about this.
> The kX mixer probably has hundreds of controls, but they are arranged in
> a tree structure.
> 

I have similar problems with the mixer controls. If I add 
p16v(24bit/96khz etc.) support to the emu10k1 driver, it will add a load 
more controls. For example, the volume controls for the 96khz channel 
are separate from the volume controls for emu10k1 48khz channels.
Maybe we need to start discussing ways to separate out mixer controls 
better.
E.g.
Global controls.
Controls specific to a pcm device.
Controls specific to a particular section of DSP code.

And be able to graphically display the mixer, so users can understand 
what is connected to what.
With the emu10k1, users can actually modify the connections between 
elements in the mixer, so the graphical display of the mixer will also 
have to be dynamic where the sound card hardware permits.

My theory is that if we can graphically display the emu10k1 mixer, we 
can use the same graphical display to display all other sound cards, 
because the emu10k1 seems to be one of the most complicated ones around.

The current qlo10k1  ( http://ld10k1.sf.net )  does a very good job so far.
Maybe we can expand the qlo10k1 to be able to handle all sound cards.

James


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
