From: Roger E Critchlow Jr <rec@elf.org>
Subject: Re: Rawmidi bug or missed feature?
Date: Sat, 2 Mar 2002 13:43:06 -0700
Message-ID: <15489.14682.987661.705929@elf2.elf.org>
References: <Pine.LNX.4.33.0203021211500.681-100000@pnote.perex-int.cz>
	<3C80D439.90AC04A9@ufh.se>
	<15489.4604.699052.853933@elf2.elf.org>
	<3C811BA0.633E219D@ufh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <3C811BA0.633E219D@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Peter Enderborg writes:
 >
 > Roger E Critchlow Jr wrote:

 [ ... ]

 > > Does this help?
 > >
 > 
 > Well. I guess it do. I will give it a try. It should work.  What about non midi
 > snd_seq_event_t.
 > The internal alsa stuff, like subscribe?
 > 

Hmm, hadn't thought about it.  You can look at the event type and
decide whether it's worth decoding, or just hand it to the decoder
and see if events which don't translate to midi just go away by
themselves, or you could look at the source for the library and see
if snd_seq_set_client_event_filter can do the work for you.

-- rec --

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
