From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: USB Audio Device: Philips Audio Set
Date: Tue, 27 Feb 2007 18:27:46 +0100
Message-ID: <1172597266.6053.1176801163@webmail.messagingengine.com>
References: <45E42E88.9080403@hubmer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45E42E88.9080403@hubmer.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Hubmer <andreas@hubmer.at>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andreas Hubmer wrote:
> I have a Philips mini hifi-system named "Philips FWM589" that can be
> used as an usb sound card. It is recognized as USB Audio device but I'm
> not able to get it to work.
> The module snd-usb-audio is loaded and in gnome a message pops up that a
> new audio device was found. In the gnome audio preferences a new device
> "USB Audio" is shown but the test sound doesn't work.

Many USB audio devices have strange or non-standard mixer controls.
Please show the output of "amixer -c 1 contents".


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
