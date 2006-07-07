From: Ben Williamson <ben.williamson@greyinnovation.com>
Subject: Re: [RFC] g_midi: New USB MIDI Gadget class driver.
Date: Fri, 07 Jul 2006 14:14:25 +1000
Message-ID: <44ADDFA1.50109@greyinnovation.com>
References: <44ACA882.7090209@greyinnovation.com>
	<20060706092715.GA13194@turing.informatik.uni-halle.de>
	<44ADACDE.3040404@greyinnovation.com>
	<200607061949.40459.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607061949.40459.david-b@pacbell.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

David Brownell wrote:
> One UDC, yes -- that's a very basic USB definition thing.  But surely one
> MIDI gadget can support multiple channels, one interface each?

Actually I was wondering if you plan to support plugging in multiple NetChip UDC
cards, but I can't imagine it would be all that useful.

At this stage g_midi only support one MIDI in jack and one MIDI out jack, because
that's all I need for now. In order to support more than that one would need to
add more jack descriptors and corresponding rawmidi substreams, none of which
should be too tough. But I think it would make the most sense for all that to
still appear under the one ALSA "card", with a single index and id as Clemens
suggested, at least as I understand it.

- Ben.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
