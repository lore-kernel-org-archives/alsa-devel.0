From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: ALSA lib application compatibility [was] Re: mi
Date: Tue, 18 May 2004 17:55:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040518175532.pochini@shiny.it>
References: <1084887054.1835.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1084887054.1835.14.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 18-May-2004 Manuel Jander wrote:

> Unfortunately i have to agree with Clemens. In my opinion the ALSA API
> is giving the applications too much freedom in choosing parameters and
> does not enforce any restrictions on hardware that can't support them.

I don't thing that freedom is a bad thing.


> As the main author of the Aureal Vortex driver, its very stupid having
> to handle arbitrary period sizes, introducing a lot of overhead and
> complexity in the driver, while the hardware just is not designed to
> handle period sizes that are not powers of two, due to page boundary
> overlapping trouble.

If the hw can't do something, the driver shouldn't try to do it. The
lowlevel driver is supposed to be "low level", ie. it's not a complete
HAL and it shouldn't emulate functions the hw can't do itself.


> Obviously as a result, OSS works much better, since
> it almost ever chooses the biggest buffer possible, resulting in a sane
> period size. Period sizes of 314.15.14 bytes are just silly, plain
> stupid. The user won't notice any difference if its 256 instead, but
> since the app insist in such period sizes it just fails, and the user
> gets no sound all. The behaviour of the user application in the end
> depends too much on the hardware it is running on.

On broken applications, yes, it is. Because when an app does
snd_pcm_hw_param_set_xyz_near() and then it crashes if the
retured settings are not what the app expects, please blame the
application, not alsa.
IMHO the problems are: 1) lack of good documentation and 2) ALSA is a
new interface and people is not as experienced with it as with OSS yet
3) ALSA is more generic and pushes the hw more than OSS, exposing hw
quirks and unknown "features" that causes troubles. I took two months
to find what made my Gina24 go berserk sometimes in unpredictable
and hardly reproducible ways. :-/


> Well, i don't ask for changes in the ALSA API, but for teaching
> application developers to -please- be polite to the ALSA drivers,
> and to take into account the possible restriction they apply.

I agree.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
