From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: problem with maudio quattro
Date: Thu, 3 Jul 2003 21:54:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <162168301796.20030703215456@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------1F13F2626283C2F"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------------1F13F2626283C2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

i already posted this problem at the alsa-user list, but it seems that
no one experienced this problem.

i've got some problems with my maudio quattro. i'm using the .asoundrc
file from alsa-project.org to use all 4 channels. (file is attached)
it worked fine with alsa up to 0.9.2.
but with all newer versions i can't access the sound interface...

i'm using pd with the -alsadev quattro flag. pd gives me the following
messages:

ALSA lib pcm.c:1127:(snd_pcm_link) SNDRV:PCM_IOCTL_LINK failed:
Operation already in progress
(...)
audio I/O stuck... closing audio

i suppose the handling of the .asoundrc file has changed from 0.9.2 to
0.9.3, but i'm not that into alsa that i could solve this problem...

beside this, i've got a second problem (with all 0.9.x drivers). using
all 4 channels i get random clicks on the incoming signals (about
-42db). i either get them on the first two channels, on the second two
channels, on all four channels or not at all.
i don't know why, but it changes whenever i restart alsa. so if i
restart alsa several times i can get a clean input signal, but it's
not the way it should work...

the /proc entry of this sound card is:
/proc/asound/card1/stream0
M Audio USB Audio Quattro at usb-00:1f.2-2 : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 11025, 22050, 44100
  Interface 4
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 88200, 96000
  Interface 4
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 11025, 22050, 44100, 48000
  Interface 4
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 11025, 22050, 44100, 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 11025, 22050, 44100
  Interface 5
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 88200, 96000
  Interface 5
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 11025, 22050, 44100, 48000
  Interface 5
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 11025, 22050, 44100, 48000

i appreciate your help...

 Tim                          mailto:TimBlechmann@gmx.net
                              ICQ: 96771783
                              http://www.nyds-exp-discogs.tk
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac
------------1F13F2626283C2F
Content-Type: application/octet-stream; name="asoundrc."
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="asoundrc."

IyBxdWF0dHJvMSBpcyBwY20wIHdoaWNoIGhhcyBhIG1heGltdW0gc2FtcGxlIHJhdGUgb2YgNDQx
MDAgYW5kIDE2CiMgYml0IHN0ZXJlbwoKICAgCXBjbS5xdWF0dHJvMSB7CiAgICAgICAgICAgICAJ
dHlwZSBodwogICAgICAgICAgICAgICAgY2FyZCAxCgkJZGV2aWNlIDAKICAgICAJfQogCiAgICAg
IAljdGwucXVhdHRybzEgewogICAgICAgICAgICAgCXR5cGUgaHcKICAgICAgICAgICAgIAljYXJk
IDEgCiAgICAgCX0KCQojIHF1YXR0cm8yIGlzIHBjbTEgd2hpY2ggaGFzIGEgbWF4aW11bSBzYW1w
bGUgcmF0ZSBvZiA5NjAwMCBhbmQgMjQKIyBiaXQgc3RlcmVvCgogICAgIAlwY20ucXVhdHRybzIg
ewogICAgICAgICAgICAgCXR5cGUgaHcKICAgICAgICAgICAgICAgIGNhcmQgMQoJCWRldmljZSAx
CiAgICAgCX0KIAogICAgICAJY3RsLnF1YXR0cm8yIHsKICAgICAgICAgICAgIAl0eXBlIGh3CiAg
ICAgICAgICAgICAJY2FyZCAxIAogICAgIAl9CgoKIy0tLS0JCgojCiMgY29tcG9zZSA0IGNoYW5u
ZWxzIGZyb20gdHdvIGNoYW5uZWwgeCB0d28gZGV2aWNlcywgaHc6MiwxIGFuZCAKIyBodzoyLDIK
IyBhc3N1bWluZyB0aGF0IGh3OjIsMSBhbmQgaHc6MiwyIGdpdmUgdGhlIHNhbWUgY29uZGl0aW9u
LCAyNF8zTEUvOTZrCiMKCnBjbS5xdWF0dHJvIHsKICAgICAgICB0eXBlIG11bHRpOwoKICAgICAg
ICBzbGF2ZXMuYS5wY20gImh3OjEsMCI7CiAgICAgICAgc2xhdmVzLmEuY2hhbm5lbHMgMjsKICAg
ICAgICBzbGF2ZXMuYi5wY20gImh3OjEsMSI7CiAgICAgICAgc2xhdmVzLmIuY2hhbm5lbHMgMjsK
CiAgICAgICAgYmluZGluZ3MuMC5zbGF2ZSBhOwogICAgICAgIGJpbmRpbmdzLjAuY2hhbm5lbCAw
OwogICAgICAgIGJpbmRpbmdzLjEuc2xhdmUgYTsKICAgICAgICBiaW5kaW5ncy4xLmNoYW5uZWwg
MTsKICAgICAgICBiaW5kaW5ncy4yLnNsYXZlIGI7CiAgICAgICAgYmluZGluZ3MuMi5jaGFubmVs
IDA7CiAgICAgICAgYmluZGluZ3MuMy5zbGF2ZSBiOwogICAgICAgIGJpbmRpbmdzLjMuY2hhbm5l
bCAxOwp9CgpjdGwucXVhdHRybyB7CiAgICAgICAgdHlwZSBodzsKICAgICAgICBjYXJkIDE7Cn0K
CgojCiMgUmVtYXAgNCBjaGFubmVscyBhcyBpbnRlcmxlYXZlZC4KIyBVc2UgcGx1ZyBpbnN0ZWFk
IG9mIHJvdXRlIGhlcmUsIHNpbmNlIDI0XzNMRSBpcyB1bmxpa2VseSBzdXBwb3J0ZWQKIyBieSBh
cHBsaWNhdGlvbnMuCiMKIyBhcmVjb3JkIC1yIDQ0MTAwIC1jIDQgLWYgczE2X2xlIC1EIHE0IC1k
IDUgL2hvbWUveHh4L3E0LndhdiAKCnBjbS5xNCB7CiAgICAgICAgdHlwZSBwbHVnOwogICAgICAg
IHNsYXZlLnBjbSAicXVhdHRybyI7CiAgICAgICAgdHRhYmxlLjAuMCAxOwogICAgICAgIHR0YWJs
ZS4xLjEgMTsKICAgICAgICB0dGFibGUuMi4yIDE7CiAgICAgICAgdHRhYmxlLjMuMyAxOwp9CgoK
CmN0bC5xNCB7CiAgICAgICAgdHlwZSBodzsKICAgICAgICBjYXJkIDE7Cn0KCiMKIyBVc2Ugcm91
dGUgcGx1Z2luIGZvciBhcHBsaWNhdGlvbnMgdGhhdCBkbyBzdXBwb3J0IDI0XzNMRQojIFRoaXMg
bG93ZXJzIGxhdGVuY3kgd2hpY2ggdGhlIHBsdWcgcGx1Z2luIGludHJvZHVjZXMgZHVlIHRvIAoj
IHJlc2FtcGxpbmcuCiMKIyAgIGFyZWNvcmQgLXIgNDQxMDAgLWMgNCAtZiBzMTZfbGUgLUQgcTRi
IC1kIDUgL2hvbWUveHh4L3E0MS53YXYKCgoKcGNtLnE0YiB7CiAgICAgICAgdHlwZSByb3V0ZTsK
ICAgICAgICBzbGF2ZS5wY20gInF1YXR0cm8iOwogICAgICAgIHR0YWJsZS4wLjAgMTsKICAgICAg
ICB0dGFibGUuMS4xIDE7CiAgICAgICAgdHRhYmxlLjIuMiAxOwogICAgICAgIHR0YWJsZS4zLjMg
MTsKCn0KCmN0bC5xNGIgewogICAgICAgIHR5cGUgaHc7CiAgICAgICAgY2FyZCAxOwp9CgojLS0t
LQ==



------------1F13F2626283C2F--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
