From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Direct Stream Digital (DSD/DST,
 One Bit Audio) HDMI pass-trough
Date: Sun, 19 Oct 2014 19:50:52 +0300
Message-ID: <5443EBEC.20404@iki.fi>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>
 <543C58AC.9000701@linux.intel.com>
 <CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>
 <543D369E.5020002@linux.intel.com>
 <CAGzU1+ERCK+nA2F9tXdR18ZQU=RJ1cUwzF3hRkDTHgc1sGd33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id CF17E260448
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 18:50:54 +0200 (CEST)
In-Reply-To: <CAGzU1+ERCK+nA2F9tXdR18ZQU=RJ1cUwzF3hRkDTHgc1sGd33A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Falout <andrej@falout.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hello,

15.10.2014, 06:30, Andrej Falout kirjoitti:
> On Wed, Oct 15, 2014 at 3:43 AM, Pierre-Louis Bossart <
> pierre-louis.bossart@linux.intel.com> wrote:
>
>> DTS-HD and AC3 use a PCM format which is rather straightforward to
>> implement but there's quite a few cases where these modes have been
>> dropped.
> 
> 
> As you say, these are rather straightforward to implement, as evident from
> the HDMI specification which describes the stream setup. Same specification
> also described DSD stream setup, which is is essence exactly the same, just
> uses the different identifiers. (CEA Standard PDF, page 66, table 47. HDMI
> specs version 1.3a, pages 72-73 for DSD(One Bit Audio) and DST audio packet
> header and body formats)

As you can see from the HDMI spec, there are 4 different types of audio
packets:

- Audio Sample Packet, used by:
  * PCM audio
  * most passthrough formats (AC-3, DTS, E-AC-3, etc.)

- High Bitrate (HBR) Audio Stream Packet, used by:
  * over-1.5Mbps passthrough formats, i.e. DTS HD and Dolby TrueHD,
    sometimes called "HD Audio passthrough".

- One Bit Audio Sample Packet
- DST Audio Packet

> Can you point out a documented case where "these modes have been dropped"?

Of the above 4 packet types, the currently available PC HDMI audio
controllers usually only support the first two.

For example, Intel and NVIDIA HDMI audio hardware follow the Intel HD
Audio specification, which only knows of the first two types (7.3.3.13,
Table 89 - "EPT Values"):
http://www.intel.com/content/www/us/en/standards/high-definition-audio-specification.html

-- 
Anssi Hannula
