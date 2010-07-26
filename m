From: Ralf Mardorf <ralf.mardorf-ZCLZIpdjs0kJGwgDXS7ZQA@public.gmane.org>
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Mon, 26 Jul 2010 12:13:40 +0200
Message-ID: <1280139220.4930.20.camel@suse11-2>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-audio-announce-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Linux Audio Developers <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>, PlanetCCRMA mailinglist <planetccrma-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>, fedora-music-list <fedora-music-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Suse 11.2 amd64
TERRATEC EWX 24/96

No issues to build it.

The faders with the +4dBu -10dBV switch here are shorter too.

CPU usage when playing and showing the meters around 5%, max around 22%,
for 0.6.0 and 1.0.0. 

CPU usage when playing and moving the DAC faders for 0.6.0 it's around
30%, but for 1.0.0 it's > 60%.

I switched several times between /usr/bin/envy24control
and /usr/local/bin/envy24control and watched both CPUs by htop.

After the 'normal' output for both versions I get:

'(envy24control:9266): Gtk-WARNING **: GtkSpinButton: setting an
adjustment with non-zero page size is deprecated

(envy24control:9266): Gtk-WARNING **: GtkSpinButton: setting an
adjustment with non-zero page size is deprecated'

Hth,

Ralf
