From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Fundamental principle of audio mixing?
Date: Mon, 24 Sep 2007 13:27:28 +0100
Message-ID: <200709241327.28239.gineera@aspect135.co.uk>
References: <8d6898730709240031q4f8a39a1m577ef7cbc114f34@mail.gmail.com>
	<5f52f6d70709240449x580d1142l4946fee3dec5bbf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 60CEB248AB
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 14:13:33 +0200 (CEST)
In-Reply-To: <5f52f6d70709240449x580d1142l4946fee3dec5bbf7@mail.gmail.com>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 24 September 2007 12:49, Claudio Matsuoka wrote:
> On 9/24/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > Can any body throw some lights on how audio mixing is done in
> > software? Basic principle?
>
> Basically you add the PCM samples (if they are at the same resolution
> and sampling rate) and renormalize if needed. The sampling rate
> conversion can be tricky tho.

I was about to say the same; multiply each sample by the applicable gain and 
add - as in this extract from Audacity/src/AudioIO.cpp:

{

     if (vt->GetChannel() == Track::LeftChannel ||
         vt->GetChannel() == Track::MonoChannel)
     {
       float gain = vt->GetChannelGain(0);

       if (gAudioIO->mEmulateMixerOutputVol)
                   gain *= gAudioIO->mMixerOutputVol;

        for(i=0; i<len; i++)
           outputFloats[numPlaybackChannels*i] += gain*tempFloats[i];
     }

     if (vt->GetChannel() == Track::RightChannel ||
         vt->GetChannel() == Track::MonoChannel)
     {
        float gain = vt->GetChannelGain(1);

        if (gAudioIO->mEmulateMixerOutputVol)
           gain *= gAudioIO->mMixerOutputVol;

        for(i=0; i<len; i++)
           outputFloats[numPlaybackChannels*i+1] += gain*tempFloats[i];
     }
}

I guess implementing it is always more complicated, though!

Alan
