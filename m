From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Haswell: Ensuring HDA codec pins refer to physical
	outputs
Date: Mon, 27 May 2013 10:21:06 +0200
Message-ID: <51A31772.5010209@canonical.com>
References: <519483F6.9060308@canonical.com> <20130527073034.GB4132@wxc-intel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130527073034.GB4132@wxc-intel>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Wang xingchao <xingchao.wang@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.de>, Jesse Barnes <jesse.barnes@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2013 09:30 AM, Wang xingchao wrote:
> On Thu, May 16, 2013 at 09:00:06AM +0200, David Henningsson wrote:
>> Hi,
>>
>> I want to take this problem up again, because it's important we get
>> this right.
>>
>> The HDA driver assumes that a codec pin widget node always refers to
>> the same physical output. With Haswell, it seems like this is not
>> guaranteed to be true. I would like to see this fixed on the
>> graphics side. If not, I don't know how to work around it on the
>> audio side.
>
> in gfx side, eld valid bit was set according to *pipe*, not physical outputs.
> For haswell, the codec pin output connected to transcoder(pipe) directly.
> I cannot confirm whether the three codec Pins are fixed connected to three
> transcoders(pipes) atm, i assume it is as i cannot find any programing manual
> in bspec(please correct me if i'm wrong here).
>
> And between transcoder and external DDI ports, there's cross-point mux used
> for selection: pipe/transcoder can select the output DDI ports.
> i.e. the physical HDMI cable is connected to DDI port B. if current using pipe
> is PIPE A, the eld valid bit for PIPE A is set. But we cannot guarantee only
> the first hdmi device is available for audio output. when play audio through
> first codec pin, it means output audio data to Transcoder A(Pipe A), that depends
> on whether PIPE A select DDI port B. If output data to second codec PIN, it
> outputs data to PIPE B, if pipe B select DDI B too, you can hear sound, even
> the second pin doesnt have valid eld info.
>
> thanks
> --xingchao
>
>>
>> The problems that occur on the audio side are:
>>
>>   1) Some BIOSes set default pin config. E g, if the machine has a
>> single HDMI out, it can set two of the codec pins to "not connected"
>> and let the third remain "jack". As a result, the HDA driver will
>> ignore the two codec pins and only enable the third. As such, HDMI
>> audio will not work correctly, unless it's the third codec pin that
>> is connected to the physical output.
>>
>>   2) Saving and restoring mutes, volumes etc is done on a per-pin
>> basis. E g, imagine that a user has a dual monitor setup and always
>> wants audio output from the left side monitor, and keep the right
>> side monitor silent. If it is not reliable which codec pin refers to
>> which physical output, one day suddenly the sound might come out on
>> the right side monitor instead.

Thanks for your answer, but it doesn't really resolve the problems as 
outlined above.

If it is utterly impossible to make sure that the audio codec pin always 
represent the same physical output, we might need even more 
communication between the audio and video driver.

For solving problem 1), the audio driver needs to inform the video 
driver what outputs are disabled by BIOS default pin config, so it can 
avoid assigning those pipes to anything with audio output. (Or we can 
just ignore BIOS default pin config for Haswell in the audio driver, but 
I'm not sure if this leads to problems somewhere else.)

For solving problem 2), we should perhaps call into the video driver 
somehow to enumerate the physical outputs and what codec pin is 
currently assigned to what output.

Also, when can these PIPE -> DDI connections change? Can we get a 
notification? Otherwise it would be very confusing for the user if 
(s)he's currently playing an audio stream and suddenly the audio comes 
out of something else than when (s)he started the stream.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
