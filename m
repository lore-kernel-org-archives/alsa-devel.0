From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Re: AC3 Passthrough on Audigy2 ZS not working
Date: Fri, 11 Mar 2005 21:39:29 +0100
Message-ID: <42320201.9080405@pobox.sk>
References: <20050311112625.770838C515@sc8-sf-spam1.sourceforge.net>	 <4231C749.80807@mail.utexas.edu>	 <1110568030.14807.44.camel@cthulhu.rlyeth.net> <1110571798.19093.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110571798.19093.9.camel@mindpipe>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: The Orqwith Vagrant <theorqwithvagrant@bredband.net>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

AFAIK:
Audigy 1 should have not swapped data, Audigy 2 swapped. Probably Audigy 
2 ZS need not swapped data too.

Peter Zubaj

>[cc'ing alsa-devel]
>
>James actually had an idea about what may cause this.
>
>Apparently the Audigy2 has a hardware bug where AC3 passthrough has a
>one sample phase error between the left and right channel, and the left
>and right channel are swapped.
>
>It's possible that some receivers really don't like this.
>
>Fortunately this bug can be 100% worked around in the DSP code.  I have
>not had time to implement it yet.  But if you can understand emu10k1 DSP
>code and want to see how it's done, check out the "Epilog" plugin from
>this (Windows) driver:
>
>http://www.kxproject.com
>
>Lee
>  
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
