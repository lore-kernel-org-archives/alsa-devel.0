From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Correct macro for Headset widgets
Date: Wed, 18 Mar 2009 11:08:57 +0000
Message-ID: <20090318110855.GA11750@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECF95A8F@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EF291038D9
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 12:08:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECF95A8F@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 17, 2009 at 08:31:55PM -0500, Lopez Cruz, Misael wrote:

> What is the correct way to declare a Headset widget in a machine
> driver? I originally thought that by using SND_SOC_DAPM_HP macro
> was enough, but it's not since the headset is both headphones and
> microphone.

Declare separate microphone and headphone widgets ("Headset Microphone"
and "Headset Headphone" or something).  While physically they're on the
same device as far as the audio routing of the codec is concerned
they are separate devices - there's no direct electrical interconnection
between the input and output side.

> Can we have a macro specifically for Headset widgets?

If we had a single macro then it'd need to expand to the two separate
widgets - we could do that but I'm not sure it'd add much to usability
since the routes would end up not linking to widgets that were directly
specified in the code.
