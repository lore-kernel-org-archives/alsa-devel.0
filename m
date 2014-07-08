From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Split a 7.1 device into 4 stereo devices
Date: Tue, 08 Jul 2014 21:26:37 +0300
Message-ID: <53BC37DD.5060104@iki.fi>
References: <1404832691.13359.9.camel@X230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 16614261A7E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 20:26:38 +0200 (CEST)
In-Reply-To: <1404832691.13359.9.camel@X230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Claessens <xavier.claessens@collabora.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

08.07.2014 18:18, Xavier Claessens kirjoitti:
> 
> Hello,
> 
> I have a 7.1 sound device and speaker-test -c8 can output on each
> speaker. But what I would like to do is using it as 4 stereo devices so
> I could play different sounds on each of them.
> 
> Ideally I would like to avoid dmix and friends to be able to have
> gapless and bit-perfect output.
> 
> On IRC "debianuser" said it is possible with hdajackretask to make it
> appear as 4 different hw devices in "aplay -l" but we didn't succeed
> doing that. Anyone knows what configuration is needed for that?
> 
> Here is my setting:
> http://www.alsa-project.org/db/?f=bf0744873d5e6d42d3adc0076c5f66189e9191b7

I guess this really belongs on alsa-user@ list, but oh well...

No idea about hdajackretask, but you can use e.g. "dshare" plugin.

Simple example below with 6ch split to three stereo devices, see
documentation/Google for more information on options. You don't see the
result in "aplay -l" but in "aplay -L".


pcm_slave.shared_dev {
        pcm "hw:CARD=PCH,DEV=7"
        channels 6
        rate 48000
}

pcm.kas {
        type dshare
        ipc_key 119922141
        slave shared_dev
        bindings {
                0 0
                1 1
        }
        hint.description "Channels 0 and 1"
}

pcm.mo {
        type dshare
        ipc_key 119922141
        slave shared_dev
        bindings {
                0 2
                1 3
        }
        hint.description "Channels 2 and 3"
}

pcm.foobar {
        type dshare
        ipc_key 119922141
        slave shared_dev
        bindings {
                0 4
                1 5
        }
        hint.description "Channels 4 and 5"
}


-- 
Anssi Hannula
