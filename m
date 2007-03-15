From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problems with virtual rawmidi
Date: Thu, 15 Mar 2007 17:45:57 +0100
Message-ID: <1173977157.21511.1179641389@webmail.messagingengine.com>
References: <200703151221.17744.vetter@bury.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200703151221.17744.vetter@bury.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Robert Vetter <vetter@bury.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Robert Vetter wrote:
> when I create a virtual midi in port in my application calling:
> 
> snd_rawmidi_open(&handle_in,NULL,"virtual",0); 
> 
> and connect midi out port from the Keystation to the midi port of the 
> Application (using QJackctl), I get problems. Some bytes are skipped, as it 
> looks like. For example: Right after everything is started and set up I press 
> a key and keyboard and get only the status byte (0x90) and note number, but 
> no velocity byte.

Does the same happen with amidi?  (try "amidi --dump --port virtual")

> Then when I release the key I don't get any status byte, 
> but only note number and velocity byte( 0 in this case).

This is running status, i.e., not a bug.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
