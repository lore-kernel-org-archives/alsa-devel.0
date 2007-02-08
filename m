From: "Brad Beveridge" <brad.beveridge@gmail.com>
Subject: mixer kcontrol documents?
Date: Thu, 8 Feb 2007 09:42:00 -0800
Message-ID: <de95dc6f0702080942m1b0d3028t5a54441ef62b374f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
In a previous thread Liam suggested that I should expose some driver
functionality via a mixer kcontrol.  I am quite new to working on ALSA
stuff, so I don't really know how to go about doing this.
I couldn't really find any info about kcontrols in
kernel/Documentation/sound/alsa, or on the ALSA website.

Basically I'd like to expose to userland a control called "De-emphasis
filter" which will take the values:
 - ON or OFF
or maybe
 - OFF, 32kHz, 44.1kHz, 48kHz

I'm unsure which to choose, but I suspect on/off and automatically
choose the correct config based on the current sampling rate - but I
don't expect it matters right now.

I've looked at the snd_kcontrol_new structure, and I assume that I
really only need to fill in the fields and (somehow) register the
structure.  Any tips, or existing drivers I can look at that will give
me a bit more knowledge here?

Thanks
Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
