From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: Re: What are the "plugins" in alsa-plugins useful for?
Date: Tue, 29 Mar 2005 17:25:11 +0200
Message-ID: <1112109911.26812.27.camel@thanatos>
References: <1111911817.18414.29.camel@thanatos>
	 <s5his3aikvi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5his3aikvi.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-29 at 16:31 +0200, Takashi Iwai wrote:
> Do you mean the purposes of plugins included in alsa-plugins package?
> 
> If yes:  The jack plugin was formerly in alsa-lib.


Yes, but what does this plugin do?  Does it allow jackd to be used as if
it were a device?  I.e.,

   application with ALSA output -> libasound -> jack

?

I assume so because jackd has its own plugin for sending output to ALSA
(i.e., in the opposite direction).


> The oss plugin is the plugin to emulate ALSA API on OSS drivers.


I.e.,

   application with ALSA output -> libasound -> OSS device

?


Second, how does one use these plugins?  Can you provide an
example .asoundrc file?

-- 
Thomas Hood <jdthood@yahoo.co.uk>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
