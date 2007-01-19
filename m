From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Having issues with an I2S driver
Date: Fri, 19 Jan 2007 08:53:50 +0100
Message-ID: <1169193230.11297.1170063083@webmail.messagingengine.com>
References: <AAFF1BF1-5C84-44DD-8545-64007D2242D4@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <AAFF1BF1-5C84-44DD-8545-64007D2242D4@purdue.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Chase Douglas <cndougla@purdue.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chase Douglas wrote:
> [...] When I send 16 bit samples to it, I have to take the stream of
> 16 bit samples and expand them to 32 bit words for every sample.

In other words, your device supports only 32-bit samples.

In this case, the driver should just use 32-bit samples directly and let
the ALSA library handle the sample format conversion.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
