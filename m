From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Recording problem
Date: Fri, 15 Sep 2006 14:39:08 +0100
Message-ID: <1158327548.22950.86.camel@localhost.localdomain>
References: <64cf23610609150319n190d4005sf78af65dc7159e5f@mail.gmail.com>
	<1158318061.22950.43.camel@localhost.localdomain>
	<64cf23610609150416k477d2d2cl4a080cddd22cfb7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <64cf23610609150416k477d2d2cl4a080cddd22cfb7a@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Vishwas P S <vishwas.ps@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-09-15 at 16:46 +0530, Vishwas P S wrote:
> Hi Liam,
>  
> Thanks for the quick response.
> I've checked that audio path and there are no programmable amps. The
> audio chip has only one set of register bits for gain control and I've
> kept it at a minimum. (Also the gain knob in the Mic at a minimum)
> But still the problems exist
> (For the same config and same hardware OSS produces very feeble sound)
>  
> Is there any configuration that I need to edit in asla.conf or
> asoundrc
> Is there any place in software where the recorded stream could be
> getting boosted or mixed??

A software gain can be ruled out by recording from the hardware directly
i.e.

arecord -f cd -Dhw:0,0 > file.wav

This will record directly from the hardware without any pcm plugins. If
the clipping is still audible, then I would compare a hardware register
dump between your OSS and ALSA drivers. 

Another possibility is that your digital audio interface (DAI) is
incorrectly configured between your codec and controller. This could
cause the audio MSB to be shifted wrt the controller by 1 bit to the
left. This would cause high gain and a lot of clipping.

Liam   




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
