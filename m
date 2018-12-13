From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7 v2] ASoC: merge audio-graph-scu into
 audio-graph - final step
Date: Wed, 12 Dec 2018 19:02:19 -0800
Message-ID: <20181213030219.GJ39861@atomide.com>
References: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muru.com (muru.com [72.249.23.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 1813C267C65
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 04:02:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 01:35]:
> 
> Hi Mark, Tony
> 
> audio-graph     card can handle normal sound card, and
> audio-graph-scu card can handle DPCM   sound card.
> But, we can't use these feature in same time now.
> 
> This is v2 of final step patches.
> 
> Tony, I think 1) and 3) patch will solve your issue.
> Can you please test these ?

Getting closer.. The DAI instances get mapped the wrong
way around for me:

soc-audio-graph-card soundcard: cpcap-hifi <-> 40124000.mcbsp mapping ok
asoc-audio-graph-card soundcard: cpcap-hifi <-> 40126000.mcbsp-dai0 mapping ok
asoc-audio-graph-card soundcard: mdm-call <-> 40126000.mcbsp-dai1 mapping ok

The second line above should not have cpcap-hifi PMIC
codec instance but the cpcap-voice PMIC codec instance
as below:

soc-audio-graph-card soundcard: cpcap-hifi <-> 40124000.mcbsp mapping ok
asoc-audio-graph-card soundcard: cpcap-voice <-> 40126000.mcbsp-dai0 mapping ok
asoc-audio-graph-card soundcard: mdm-call <-> 40126000.mcbsp-dai1 mapping ok

Any ideas why it thinks mcbsp2 has two DAIs instead
of mcbsp3 having two DAIs?

The dts snippet I'm now using is below.

Regards,

Tony

8< ---------------
&mcbsp2 {
	...
        ports {
                #address-cells = <1>;
                #size-cells = <0>;

                mcbsp2_port: port@0 {
                        reg = <0>;
                        cpu_dai2: endpoint@0 {
                                dai-format = "i2s";
                                remote-endpoint = <&cpcap_audio_codec0>;
                                frame-master = <&cpcap_audio_codec0>;
                                bitclock-master = <&cpcap_audio_codec0>;
                        };
                };
        };
};

&mcbsp3 {
	...
	ports {
		mcbsp3_port: port@0 {
			#address-cells = <1>;
			#size-cells = <0>;

			cpu_dai3: endpoint@0 {
				reg = <0>;
				dai-format = "dsp_a";
				frame-master = <&cpcap_audio_codec1>;
				bitclock-master = <&cpcap_audio_codec1>;
				remote-endpoint = <&cpcap_audio_codec1>;
			};
			cpu_dai_mdm: endpoint@1 {
				reg = <1>;
				dai-format = "dsp_a";
				frame-master = <&cpcap_audio_codec1>;
				bitclock-master = <&cpcap_audio_codec1>;
				remote-endpoint = <&mot_mdm6600_audio_codec0>;
			};
		};
	};
};
