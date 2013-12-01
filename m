From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: What-did-you-plugin-dialog
Date: Sun, 1 Dec 2013 16:36:59 +0600
Message-ID: <CAN_LGv3MwSUGHvE5=6U=huAdkzD=mGP89ta7d_ofJ54Y56mRAg@mail.gmail.com>
References: <52947A6E.6010302@canonical.com>
	<1385470453.2226.26.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52949CCA.2060601@canonical.com>
	<1385473638.2226.48.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52951347.9000200@canonical.com> <5295A121.2010202@gmail.com>
	<5295A7C2.2090100@canonical.com>
	<CAN_LGv1F4cTB2cK+rL30N3nbbwyxi23cLYHR6emMC5CbNLP4jQ@mail.gmail.com>
	<CAN_LGv0y2WcYMn8M5rjT1d-2jahh_u-W2D_LnRkMsXXD=ENzdA@mail.gmail.com>
	<CAN8cciZ-y397dLGV_xC3xibo3PY9aE-RYQEB4_dkwRtzN+JnqQ@mail.gmail.com>
	<CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
	<CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
	<CAN_LGv0F6g6L41Se72zdaq4u0DAPJzRc4ZwCMqPPJ06TCFS=qA@mail.gmail.com>
	<CAN8ccibLpVXqcHHdJwfv=_FF8z2hE6frsY8Gg6NRNQibsu2Okw@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8ccibLpVXqcHHdJwfv=_FF8z2hE6frsY8Gg6NRNQibsu2Okw@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2013/12/1 Raymond Yau <superquad.vortex2@gmail.com>:

All tests below were done with the original patch, as the suggested
modification breaks 8ch mode here.

> In 8ch mode, do the "Line jack" return true when you plugged "Side Speaker"
> ?

Yes, the state reflects whether something is plugged into the blue jack.

> pactl list
>
> should "line in" list as not available when channel mode changed to "8 ch" ?

Unfortunately, it is "available" if there is something plugged in and
"mot available" if there is nothing plugged in.

> Should changes in "channel mode" , "Headphone Mic jack mode" or "Mic Jack
> Mode" trigger an event so that pulseaudio server probe the sound card again
> ?

Changes in "channel mode" do not trigger anything that pulseaudio -vvv
considers loggable. Changes from 8ch to 6ch do not cause the 7.1
profiles to disappear.

The device has no controls that contain "mic jack mode" as a substring
and are controllable via alsamixer.

-- 
Alexander E. Patrakov
