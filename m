From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problems with nVidia Corporation MCP61 High
 Definition Audio
Date: Tue, 05 Dec 2006 10:13:43 +0100
Message-ID: <1165310023.9726.278914247@webmail.messagingengine.com>
References: <88e62d960612050109j15a4a41y2b491c9a8e046f47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <88e62d960612050109j15a4a41y2b491c9a8e046f47@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ciprian Sturza <ciprian.sturza@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ciprian Sturza wrote:
> The PCI Audio is nVidia Corporation MCP61 High Definition Audio
> ...
> ./configure --with-cards=intel8x0

The snd-intel8x0 driver is for AC'97 controllers.  Your HDA controller
requires the snd-hda-intel driver.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
