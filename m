From: Steven Wawryk <stevenw@acres.com.au>
Subject: Re: Adding channels on multicodec soundcard
Date: Fri, 15 Jan 2016 16:54:25 +1030
Message-ID: <56989099.3050404@acres.com.au>
References: <5698894D.2030002@acres.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.acres.com.au (mail.acres.com.au [150.101.238.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F0EE6260589
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 07:24:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by loki.acres.com.au (Postfix) with ESMTP id 3ADBEC2C2F
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 16:54:32 +1030 (CST)
Received: from mail.acres.com.au ([127.0.0.1])
 by localhost (loki.acres.com.au [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ug2sA7QBWv9Z for <alsa-devel@alsa-project.org>;
 Fri, 15 Jan 2016 16:54:25 +1030 (CST)
Received: from [192.0.2.164] (krill.acres.com.au [192.0.2.164])
 by loki.acres.com.au (Postfix) with ESMTP id 50339C29A5
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 16:54:25 +1030 (CST)
In-Reply-To: <5698894D.2030002@acres.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I should have added that there is a pair (capture + playback) of serial 
"I2S" links (actually TDM) between the Zynq and *each* codec.


On 15/01/16 16:23, Steven Wawryk wrote:
>
> Hi,
>
> I'm trying to write an ALSA soundcard driver module for an embedded 
> Zynq-based system with 4 Cirrus CS42448 codecs.  Each codec has 6 
> analog output channels and I'd like the "soundcard" to have 24 
> channels (6 to each codec).  I've been having trouble getting it to do 
> this.  The hw_params for the codec, card and "I2S" IP core drivers all 
> get the same parameters, including number of channels.
>
> When I define 4 snd_soc_dai_link's, each with 1 codec, then 4 
> "devices" are set up for the card and I can access 6 channels on 1 
> codec (1 "device") at a time.  When I define 1 snd_soc_dai_link with 4 
> codecs then 1 "device" is set up and I can still only access 6 
> channels, but it appears to use all 4 codecs (somehow - I haven't yet 
> worked out the channel allocation).  I can't seem to get 24 channels 
> to the card, splitting into 6 channels to each of the codecs.
>
> Can anyone suggest how I should be going about this?
>
> The linux kernel is 3.17 from PetaLinux (Xilinx).
>
> Cheers,
> Steve
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
