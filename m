From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: the monitors with working Displayport audio
Date: Wed, 9 Nov 2011 15:28:28 +0800
Message-ID: <20111109072828.GA24565@localhost>
References: <20111109072053.GA21956@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20111109072053.GA21956@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "Lv, Jane" <jane.lv@intel.com>, "Barnes, Jesse" <jesse.barnes@intel.com>, Christopher White <c.white@pulseforce.com>
List-Id: alsa-devel@alsa-project.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are the EDID for the DELL monitors, grabbed by command

        cp /sys/class/drm/card0-DP-3/edid .

Thanks,
Fengguang

On Wed, Nov 09, 2011 at 03:20:53PM +0800, Wu Fengguang wrote:
> Hi Takashi,
> 
> I enumerated all the DELL DisplayPort monitors in our lab and find
> only two of them being able to produce audible DisplayPort audio...
> 
> - DELL 2408WFP
> - DELL 2709W
> - DELL 3008WFP
>         no CEA extension found
> 
> - DELL U2410
>         ELD reports OK but cannot hear DP sound
> 
>         monitor_present         1
>         eld_valid               1
>         monitor_name            DELL U2410
>         connection_type         DisplayPort
>         eld_version             [0x2] CEA-861D or below
>         edid_version            [0x3] CEA-861-B, C or D
>         manufacture_id          0xac10
>         product_id              0xf017
>         port_id                 0x0
>         support_hdcp            0
>         support_ai              0
>         audio_sync_delay        0
>         speakers                [0x1] FL/FR
>         sad_count               1
>         sad0_coding_type        [0x1] LPCM
>         sad0_channels           2
>         sad0_rates              [0xe0] 32000 44100 48000
>         sad0_bits               [0xe0000] 16 20 24
> 
> - DELL U3011
>         ELD and DP sound both OK
> 
>         monitor_present         1
>         eld_valid               1
>         monitor_name            DELL U3011
>         connection_type         DisplayPort
>         eld_version             [0x2] CEA-861D or below
>         edid_version            [0x3] CEA-861-B, C or D
>         manufacture_id          0xac10
>         product_id              0x4065
>         port_id                 0x0
>         support_hdcp            0
>         support_ai              0
>         audio_sync_delay        0
>         speakers                [0xf] FL/FR LFE FC RL/RR
>         sad_count               1
>         sad0_coding_type        [0x1] LPCM
>         sad0_channels           6
>         sad0_rates              [0x1ee0] 32000 44100 48000 96000 176400 192000 384000
>         sad0_bits               [0xe0000] 16 20 24
> 
> - Eizo FlexScan EV2333W
>         ELD and DP sound both OK
> 
>         monitor_present         1
>         eld_valid               1
>         monitor_name            EV2333W
>         connection_type         DisplayPort
>         eld_version             [0x2] CEA-861D or below
>         edid_version            [0x3] CEA-861-B, C or D
>         manufacture_id          0xc315
>         product_id              0x2068
>         port_id                 0x0
>         support_hdcp            0
>         support_ai              1
>         audio_sync_delay        0
>         speakers                [0x1] FL/FR
>         sad_count               1
>         sad0_coding_type        [0x1] LPCM
>         sad0_channels           2
>         sad0_rates              [0x1ee0] 32000 44100 48000 96000 176400 192000 384000
>         sad0_bits               [0xe0000] 16 20 24
> 
> Thanks,
> Fengguang

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=edid-dell-3008wfp
Content-Transfer-Encoding: base64

AP///////wAQrDZATDUxMScTAQSlQSl4Io2FrU81sSUOUFSlSwCBgKlA0QDRQHFPgQCzAAEB
sGgAoKBALmAwIDYAgZAhAAAeAAAA/wBHNTAxSDk5UTExNUwKAAAA/ABERUxMIDMwMDhXRlAK
AAAA/QAxVh1xHAAKICAgICAgAMU=

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=edid-dell-u2410
Content-Transfer-Encoding: base64

AP///////wAQrBfwTDFZMQ0VAQS1NCB4Oh7Frk80sSYOUFSlSwCBgKlA0QBxTwEBAQEBAQEB
KDyAoHCwI0AwIDYABkQhAAAaAAAA/wA4MldYRDEzTDFZMUwKAAAA/ABERUxMIFUyNDEwCiAg
AAAA/QA4TB5REQAKICAgICAgAawCAx3xUJAFBAMCBxYBHxITFCAVEQYjCQcHgwEAAAI6gBhx
OC1AWCxFAAZEIQAAHgEdgBhxHBYgWCwlAAZEIQAAngEdAHJR0B4gbihVAAZEIQAAHowK0Iog
4C0QED6WAAZEIQAAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIQ==

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=edid-dell-u3011
Content-Transfer-Encoding: base64

AP///////wAQrGVATDE5MBQVAQS1QCh4Oo2FrU81sSUOUFSlSwBxT4EAgYCpQNEA0UABAQEB
4mgAoKBALmAwIDYAgZEhAAAaAAAA/wBQSDVOWTE1SjA5MUwKAAAA/ABERUxMIFUzMDExCiAg
AAAA/QAxVh1xHAAKICAgICAgAR4CAx3xUJAFBAMCBxYBBhESFRMUHyAjDX8Hgw8AAAI6gBhx
OC1AWCxFAIGRIQAAHgEdgBhxHBYgWCwlAIGRIQAAngEdAHJR0B4gbihVAIGRIQAAHowK0Iog
4C0QED6WAIGRIQAAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdw==

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=edid-dell-2709w
Content-Transfer-Encoding: base64

AP///////wAQrDGgU1Q2MAMTAQS1OiR4Iun1rFEwtCURUFSlSwCBgKlAcU+zAAEBAQEBAQEB
KDyAoHCwI0AwIDYARGghAAAaAAAA/wBHTjcyMTkxRjA2VFMKAAAA/ABERUxMIDI3MDlXCiAg
AAAA/QA4TB5TEQEKICAgICAgAM8=

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=edid-dell-2408wfp
Content-Transfer-Encoding: base64

AP///////wAQrCugU05SMBgSAQSlNCB4IrMlrFEwtCYQUFSlSwCBgKlAcU8BAQEBAQEBAQEB
KDyAoHCwI0AwIDYAB0AhAAAaAAAA/wBHMjkzSDg2QjBSTlMKAAAA/ABERUxMIDI0MDhXRlAK
AAAA/QA4TB5TEQEKICAgICAgAHs=

--wac7ysb48OaltWcw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--wac7ysb48OaltWcw--
