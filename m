From: Fred Gleason <fredg@salemradiolabs.com>
Subject: Re: Upgrade driver to 1.0.6, memory allocation?
Date: Thu, 19 Aug 2004 09:01:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408190901.48652.fredg@salemradiolabs.com>
References: <505401c48598$4a891ec0$72cb010a@mail2world.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <505401c48598$4a891ec0$72cb010a@mail2world.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>, alsa-devel@lists.sourceforge.net
Cc: linux@blennerhassett.gen.nz
List-Id: alsa-devel@alsa-project.org

On Wednesday 18 August 2004 22:57, Eliot Blennerhassett wrote:

> Is there a rationale for making the substreams limit 4 as opposed to any
> other number?

I take it these streams map one-to-one with HPI stream resources?  If four is 
the limit, what happens if there are already four or more streams open via 
HPI?  Would snd_pcm_open() fail, or could the driver 'redirect' in some way 
to an unused stream?

Cheers!


|-------------------------------------------------------------------------|
| Frederick F. Gleason, Jr. | Director of Broadcast Software Development  |
|                           |             Salem Radio Labs                |
|-------------------------------------------------------------------------|
|  Some people say a front-engine car handles best.  Some people say a    |
|  rear-engine car handles best.  I say a rented car handles best.        |
|                                          --P.J. O'Rourke                |
|-------------------------------------------------------------------------|



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
