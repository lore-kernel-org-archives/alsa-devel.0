From: "Christian F.K. Schaller" <christian@fluendo.com>
Subject: How to proper handle surround sound setups
Date: Tue, 20 Feb 2007 13:40:58 +0100
Message-ID: <1171975258.10279.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Hi Alsa devs,
We have a long discussion today in the GStreamer community about how to
correctly handle surround sound setups.

The ideal solution we are looking for is a situation where the user do
not need to configure anything, things just work in an optimal fashion
depending on their hardware. We are not sure however what exactly is the
status of a lot of things both in theory and in practice. So I am
sending out this email to you.

GStreamer currently queries the alsadevice for its capabilities and
tries to negotiate an optimal path through its playback pipeline with a
little quality loss as possible.

This means that if the soundcard reports supporting surround sound and
you are playing a multichannel file then GStreamer will output surround
sound by default in most cases.

The discussion started as it seems my ICH4 laptop mistakenly reporting
supporting surround sound on the PCM device, while its only supports
surround sound indirectly through its s/pdif output(is this a known
bug?). This caused me to get only the side speaker output in my
headphones which meant almost all dialog in the movie clips where gone.

I thus started arguing that we should default to stereo due to this and
only do surround sound if the users selects it on the application level
as even if the user truly has a surround capable system they don't
necessarily have more than two stereo speakers connected.

The debate then turned to whether connected speakers connected can be
autodetected or not. Some people reported that their Mac's and Vista
systems did detect at least some speaker detection, but I was not able
to clarify if the systems could actually tell you that you have for
instance LF, center and LR + a woofer connected and so on.

So my questions to you are:
a) do most modern soundcards actually report what is connected to them
so the computer could use that information to automatically choose the
correct sound output?
b) if so what is the state of supporting that functionality in ALSA? Is
it widely implemented or in the process of being so an can it be queried
using the libalsa API?

The second issue might be caused by our limited understanding of ALSA. 
So in the expected case of not being able to detect number of speakers
connected we need to default to stereo as that is the only way to give
all users something sane out of the box. The question is how we should
do this within GStreamer. Currently we are querying ALSA and negotiating
based on the optimal capabilities of the card and the sound stream.

We now have two ways to resolve the issue. One is to keep the current
approach and set 'stereo' as the preferred channels layout through
something we call a capsfilter. This approach has some drawbacks as it
requires a lot of logic in the application when overriding the default
of stereo or you risk your surround config being interpreted as a wish
for upmixing of mono/stereo streams to surround.

The other alternative we are looking at which might simplify things for
us is to use the virtual devices which expose the different surround
scenarios like using for instance:

defaults.pcm.surround51.device for surround51 output.

In this scenario we use the stereo device by default which would then
only report back support for stereo and thus negotiate correctly to
stereo with all elements. Users can then through the applications choose
the 5.1 audio device at which point we would change to the 5.1 device
like the one above. Our worry the by the playback autoplugger which as
you know is rarely the casere though is what happens with stereo output
as we of course do not want that upmixed. Do these 5.1 virtual devices
also handle stereo correctly? What would be the expected result when
querying these devices through the libalsa API

Christian




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
