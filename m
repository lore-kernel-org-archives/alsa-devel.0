From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC] question regarding codec DAI ops
Date: Mon, 23 Jun 2014 09:30:19 +0200
Message-ID: <53A7D78B.1050508@st.com>
References: <53A44007.1000008@st.com> <20140621102644.GQ5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 773B22654EB
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 09:30:42 +0200 (CEST)
In-Reply-To: <20140621102644.GQ5099@sirena.org.uk>
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
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


On 06/21/2014 12:26 PM, Mark Brown wrote:
> On Fri, Jun 20, 2014 at 04:07:03PM +0200, Arnaud Pouliquen wrote:
>
>> I have a platform with several audio IOs (DAC , HDMI...) and I2S In/out
>> connectors.
>> I'm using my codec driver but for this I2S output i used dummy codec driver
>> with the snd-soc-dummy-dai dai.
> Why are you using the dummy driver?  This is intended to stub things out
> in some DPCM situations rather than as something that should be used in
> normal code.
My platform is a base for several projects and customers. In this 
context some extra I2S bus are available for extensions.
I have  two use cases to support.
- Possibility to test I2S bus without audio codec associated.
- Support client that does not use ASOC for audio codec ( a.e one 
manage  HDMI in his display driver...)
To be able to support these use cases i use device tree to construct the 
alsa card.  if no asoc codec present, i connect dummy one.
If customer want to use another codec they have just  to change device 
tree.
Here is an example of my device tree declaration.
     sound {
         compatible = "st,snd-soc-sti";
         st,card-name = "audio";
         st,audio-routing =
             /* Analog out route */
             "Analog out","DAC",
             "DAC","dac_p";

         st,asoc-platform = <&sti_asoc_platform>;
         backend-name  = "HDMI_out", "PCM_out",
                     "Analog_out", "spdif",
                     "HDMI_in", "PCM_in";
         backend-cpu-dai = <&snd_uni_player0 &snd_uni_player1
                     &snd_uni_player2 &snd_uni_player3
                     &snd_uni_reader0 &snd_uni_reader1 >;
         backend-codec = <&sti_sasg_codec 0
                     &sti_sasg_codec &sti_sasg_codec
                     0 0>;
         backend-codec-dai = "sas-dai-hdmi-out", "snd-soc-dummy-dai",
                     "sas-dai-dac", "sas-dai-spdif-out",
                     "snd-soc-dummy-dai","snd-soc-dummy-dai";
     };

backend-codec  specify the codec driver. If 0 dummy codec is used.
>
>>  From your point of view, what should be best solution?
> I think we need to take a step back and work out what the goal is here.
