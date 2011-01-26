From: Patrick Lai <plai@codeaurora.org>
Subject: Re: [QUERY] Download calibration data to co-processor
Date: Tue, 25 Jan 2011 23:58:54 -0800
Message-ID: <4D3FD43E.9090001__804.688203106885$1296114007$gmane$org@codeaurora.org>
References: <4D3E6A0D.40308@codeaurora.org>
	<20110125133643.GD31453@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110125133643.GD31453@opensource.wolfsonmicro.com>
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
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 1/25/2011 5:36 AM, Mark Brown wrote:
> On Mon, Jan 24, 2011 at 10:13:33PM -0800, Patrick Lai wrote:
>
>
> What we're doing for this currently is passing the configuration data in
> platform data or via request_firmware()  (mostly using the latter for
> larger data).  At the minute we're loading everything at startup rather
> than on demand, with the drivers presenting an enum with the available
> use cases if there's more than one.
>
Can you point me to an example driver which does exactly what you 
describe? Loading at startup is what I would like to avoid. That means
calibration data for all use cases would be packed into single binary file.

>> perform extensive parsing of data. Furthermore, host processor and
>> co-processor need to establish common use case definitions so
>> co-processor know what chunk of calibration data to apply in certain
>> scenario such as device switch.
>
> I don't understand the issue with either parsing cost or with listing
> use cases  - I'd expect that for multiple use cases the host processor
> and (if required) the coprocessor would parse the set of use cases out
> of the data (for many systems the coprocessor won't know anything about
> use cases and they'll be managed by the host reprogramming coefficients
> to switch), and I'd expect that either the format will be defined to
> something readily usable or the host can do the required processing.
> Could you elaborate on the issues here, it's possible I'm missing
> something about the sort of data you're looking at?

Parsing is not a big concern as the co-processor in question does 
parsing to some extend. The calibration binary contains coefficients for 
different features on the co-processor for a given playback or capture 
path. I would like to keep parsing based on features(i.e type of filter) 
supported on the co-processor but stay use case agnostic. A more 
concrete example would be reapplying calibration data for different 
device mode(speaker, headphone). In this case, if calibrations data for 
all devices is packed into single binary, host-processor and 
co-processor would need to maintain common device ID. When there is 
device switch, host-processor passes new device ID so co-processor know 
the right set of calibration to apply. As a device mode is constructed 
by connecting components in the CODEC through mixer commands, 
co-processor should also stay device-mode agnostic. That's why I believe 
push down model would work better based what I have stated above.

>> If there is no precedent, my idea is to apply calibration data
>> through sysfs. After introduction of ASoC multi-component
>> architecture, PCM stream created from dailink is registered as
>> device. So, there is syfs entry for each dailink. If ALSA ASoC can
>> provide API for drivers(platform/CPU) to register additional
>> attributes to the PCM device, this approach gives user-space
>> application the ability to push down new calibration as audio
>> situation changes. I believe it's a viable solution to my problem
>> and perhaps can be useful to other systems as well.
>
> I'm not enthused about sysfs for this as it means applications end up
> needing custom infrastructure for individual cards, or UCM needs to end
> up integrating that anyway, so we'd have some issues at the application
> level when writing generic code for multiple systems

That's exactly why we need UCM, right? Though application request for 
headphone device, different system would have different set of mixer 
controls to construct headphone device. That's why I do not see why each 
DAI link cannot have its own unique attributes.

we'd need support
> for enumerating and understanding the available settings.  In terms of
> actually loading the data it doesn't really offer anything that
> request_firmware() doesn't except for a push interface and it's not got
> the existing userspace infrastructure that request_firmware() does.

Request_frmware() can accomplish my request but requires common device 
ID to be defined. If there is new use case with new device defined, 
co-processor would have to be updated with new ID and it's not a 
scalable solution. Another approach is to devise mixer command which 
passes name of calibration file. This command triggers 
request_firmware() being called with file name passed as parameter of 
the command. The caveat is, unless user-space application wants to 
extract calibration data for a device mode and save into file system at 
run-time, we would end up having numerous calibration files in the file 
system.
> Thinking off the top of my head I think we're reasonably covered from
> the point of view of actually injecting data already but we currently
> don't have a way to add additional data at runtime (eg, when doing a
> calibration run).  If we added a way for applications to say "I'd like
> to add some new coefficients to this feature" then that would address
> that aspect of things, I think?


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
