From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire Speakers/Griffin FireWave
	surround driver
Date: Mon, 7 Feb 2011 17:49:19 +0100
Message-ID: <20110207174919.43b85e16@stein>
References: <4D46933D.5050609@ladisch.de> <4D4FB7C8.7090501@ladisch.de>
	<4D4FB7F6.8000801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4D4FB7F6.8000801@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Feb 07 Clemens Ladisch wrote:
> +	static const struct device_info lacie_speakers = {
> +		.driver_name = "FWSpeakers",
> +		.short_name = "Firewire Speakers",
> +		.long_name = "LaCie Firewire Speakers",

FWIW, it is spelled "LaCie FireWire Speakers" in LaCie's printed material
and on their web site, whereas their firmware programmers put "LaCie
Firewire speakers" as model descriptor leaf into the Configuration ROM.
Does the precise case of device_info strings matter to userspace?
-- 
Stefan Richter
-=====-==-== --=- --===
http://arcgraph.de/sr/

------------------------------------------------------------------------------
The modern datacenter depends on network connectivity to access resources
and provide services. The best practices for maximizing a physical server's
connectivity to a physical network are well understood - see how these
rules translate into the virtual world? 
http://p.sf.net/sfu/oracle-sfdevnlfb
