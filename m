From: Angelo Dureghello <angelo70@gmail.com>
Subject: Wolfson codec, problem on mixer levels on kernel 3.17.0
Date: Mon, 20 Oct 2014 09:19:44 +0200
Message-ID: <5444B790.8000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Hi,

moving from kernel 3.5.1 to 3.17, amixer cannot read certain mixer 
controls,
giving Input/output error:

[root@test ~]# amixer cget numid=12
numid=12,iface=MIXER,name='Capture Volume'
   ; type=INTEGER,access=rw---R--,values=2,min=0,max=255,step=0
amixer: Control default element read error: Input/output error

So i had to disable those controls in the codec code:

     ...

     //SOC_DOUBLE_R_TLV("Capture Volume", WM8758_LEFT_ADC_DIGITAL_VOL,
     //    WM8758_RIGHT_ADC_DIGITAL_VOL, 0, 255, 0, adc_tlv),
     ...
     //SOC_SINGLE("DAC Playback Limiter Switch", WM8758_DAC_LIMITER_1, 
8, 1, 0),
     //SOC_SINGLE("DAC Playback Limiter Decay", WM8758_DAC_LIMITER_1, 4, 
10, 0),
     //SOC_SINGLE("DAC Playback Limiter Attack", WM8758_DAC_LIMITER_1, 
0, 11, 0),
     ...
     //SOC_ENUM("EQ4 Bandwith", eq4_bw),
     //SOC_ENUM("EQ4 Cutoff", eq4_cutoff),
     //SOC_SINGLE_TLV("EQ4 Volume", WM8758_EQ4_PEAK_3, 0, 24, 1, eq_tlv),
     ...

Is it possible sonething is changed in these macroes, so that the amixer 
cannot
access the controls anymore ?

Every help is appreciated,
many thanks
angelo
