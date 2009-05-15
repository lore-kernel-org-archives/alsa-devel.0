From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 11:37:16 +0300
Message-ID: <200905151137.16452.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BA3F103976
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 10:37:23 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Friday 15 May 2009 11:21:29 ext Lopez Cruz, Misael wrote:
> I'm adding the voice dai to sdp3430 machine driver, but the codec's
> "twl4030_voice_startup" function has a requirement for voice to work: the
> codec has to be in option2. How can I switch the codec to option2 mode?
> There is no control for doing that, and the only way I see is to
> directly modify the reg cache, but I assume that is not the right way
> to do it.

I have some complains about the current implementation of the voice dai in =
the =

twl4030 codec (regarding on how the two dai works (or in fact should work) =

with DAPM), but it is a different story.

I would suggest to add an enum to twl4030_snd_controls to select between =

Option1 and Option2.

>
> Could you please clarify?
>
> -Misa

-- =

P=E9ter
