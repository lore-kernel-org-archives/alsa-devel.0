From: Patrick Lai <plai@codeaurora.org>
Subject: [QUERY] Download calibration data to co-processor
Date: Mon, 24 Jan 2011 22:13:33 -0800
Message-ID: <4D3E6A0D.40308__6907.50253056667$1295940249$gmane$org@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

I am looking for ways to download audio calibration data to a 
co-processor under ALSA framework. I would like to know if there is 
already a precedent which handles this use case. I considered 
request_firmware() approach but there are few drawbacks to this 
approach.  The audio calibration data size can be substantial
as number of audio use cases grows. It also requires co-processor 
perform extensive parsing of data. Furthermore, host processor and 
co-processor need to establish common use case definitions so 
co-processor know what chunk of calibration data to apply in certain 
scenario such as device switch.

If there is no precedent, my idea is to apply calibration data through 
sysfs. After introduction of ASoC multi-component architecture, PCM 
stream created from dailink is registered as device. So, there is syfs 
entry for each dailink. If ALSA ASoC can provide API for 
drivers(platform/CPU) to register additional attributes to the PCM 
device, this approach gives user-space application the ability to push 
down new calibration as audio situation changes. I believe it's a viable 
solution to my problem and perhaps can be useful to other systems as well.

Your feedback is appreciated.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
