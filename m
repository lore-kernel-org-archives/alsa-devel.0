From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Question about control names.
Date: 02 Jul 2003 21:24:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057195497.6307.55.camel@deimos>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I wrote support for the Hardware Equalizer (10 band stereo = 20
controls) for the Aureal Vortex cards. For testing purposes i used the
controls as "MIXER" type controls, so they are visible from any mixer.
The question: How should they be named ? Is the type "MIXER" acceptable
? In my opinion it is at least pretty convenient.

Now that the EQ is done, i would like to write support for a EQ peak
visualization support that the AUreal cards provide. That is there are
hardware registers that can be read to obtain the peak values of each
frequency band. The same question as above: How should that readonly
control to be named ?
I guess it would be bad idea having it added like a MIXER type control.
I was thinking of using HWDEP instead, and write a special graphical
application for the visualization purpose (accessing the ALSA controls).
Is there something like this done before ??


And at last, could someone please with suggar on the top update the ALSA
support matrix ???!! The Aureal Vortex cards -YES THEY ARE- supported.
(http://savannah.nongnu.org/projects/openvortex/)

Best Regards

Manuel Jander.




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
