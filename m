From: Paul Davis <pbd@op.net>
Subject: Re: Re: Multiple PCM files
Date: Wed, 31 Jul 2002 18:18:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17a1lS-0000L9-00@usw-sf-list1.sourceforge.net>
References: <121a01c238cf$b88c66b0$360110ac@dillon>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 31 Jul 2002 21:20:31 BST."
             <121a01c238cf$b88c66b0$360110ac@dillon>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Nick French <nick@greensignal.com>
Cc: Philipp Vollmer <vollmer.philipp@t-online.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Exactly. I would prefer the second as if I needed to add a third, 4th its
>takes no effort and I don't reinvent the wheel as they say.
>
>Does alsa support 2 or is this just JACK's.

No, ALSA does not support it *in general*. Some interfaces will work
this way, some will not. In theory, the ALSA "share" device type will
allow this, but apparently almost no-one has ever used it except its
main author.

>The mathematics may be simple for 1 but why should it be done over and over
>again. An API is meant to take away repetitive annoyances ;)

the mathematics, such as they are, consist of addition.

the real problems you face have to do with sample rate and sample bit
width conversion, which are entirely different. i and others have said
before that it would be nice if alsa-lib exposed the code it contains
to do this stuff so that it could used in other contexts (not just
hidden as part of "plug" or "plughw" device implementation.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
