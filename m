From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: hw_rule
Date: Fri, 09 May 2003 19:04:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBBDF87.7040205@libero.it>
References: <1052435969.2728.15.camel@Jay> <s5hbrycb3fk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrycb3fk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:
> At 08 May 2003 23:19:28 +0000,
> Giuliano Pochini wrote:
> 
>>
> 
>>- what are ch.openmin, openmax, empty ?  They are taken into account
>>because if I don't clear the structure the rule doesn't work anymore.
> 
> 
> openmin/openmax are the minimum and maximum value but the
> configuration cannot be exactly these values.

Not exactly: openmin/openmax are the flags that, when set to true, means 
that min/max are not valid value of the numeric interval.

They're sensible only for non integer intervals.

As an example the interval 44100.1 - 48000.4 is represented as an 
interval 44100 - 48001 with both boundaries open.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
