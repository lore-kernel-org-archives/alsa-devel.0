From: David Henningsson <david.henningsson-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [pulseaudio-discuss] alsa ucm in pulseaudio
Date: Fri, 14 Oct 2011 08:35:10 +0200
Message-ID: <4E97D81E.4080607@canonical.com>
References: <CAJ4+uhUoBqTfDdDGEo_cKpzpdOmCPODfts7Afij1vafW+hwG=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAJ4+uhUoBqTfDdDGEo_cKpzpdOmCPODfts7Afij1vafW+hwG=w@mail.gmail.com>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: General PulseAudio Discussion <pulseaudio-discuss-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 10/14/2011 04:47 AM, Feng Wei wrote:
> Hi Liam, Mark, Colin, and all,
>    I study the codes in pulseaudio and alsa ucm patch recently, and
> create a page of my study result. I appreciate your feedback. The page
> is at https://wiki.linaro.org/WorkingGroups/Middleware/Multimedia/Specs/1111/AudioIntegration/UCMPulseAudio/Analyzation.
>    Also if needed, I'm glad to contribute to the integration of alsa
> ucm in pulseaudio.
>    Thank you.

Oh, nice diagrams :-) Some of them might be useful additions to the 
PulseAudio wiki.

I think the modelling of UCM concepts onto PulseAudio concepts is an 
important discussion. In PulseAudio, profiles are mainly connected to 
device strings, how to open the devices, channels supported, whereas 
ports are just alsa mixer kcontrol changes. UCM verbs, as I understand 
it, contain both.

In this context, I have a question: Can more than verb be active at a 
time for a specific card (e g can both "hifi" and "record" be active for 
the panda), and if so, how is it described in UCM what verbs that can 
coexist and which ones are mutually exclusive? I believe PulseAudio is 
going to need that information in order to be able to know how to create 
its profiles.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
