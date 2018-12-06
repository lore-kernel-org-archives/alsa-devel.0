From: shuah <shuah@kernel.org>
Subject: Re: [RFC PATCH v8 4/4] sound/usb: Use Media Controller API to share
 media resources
Date: Thu, 6 Dec 2018 08:34:57 -0700
Message-ID: <3aef49a1-2dd7-c6c6-7c2e-5ba3cc76a695@kernel.org>
References: <cover.1541118238.git.shuah@kernel.org>
 <ba3bb65b4250fa470c7319d50ebdf1047793efad.1541109584.git.shuah@kernel.org>
 <0b919080-669a-a266-c85c-66dc724a536b@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0b919080-669a-a266-c85c-66dc724a536b@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Hans,

On 11/20/18 4:54 AM, Hans Verkuil wrote:
> On 11/02/2018 01:31 AM, shuah@kernel.org wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Change ALSA driver to use Media Controller API to share media resources
>> with DVB, and V4L2 drivers on a AU0828 media device.
>>
>> Media Controller specific initialization is done after sound card is
>> registered. ALSA creates Media interface and entity function graph
>> nodes for Control, Mixer, PCM Playback, and PCM Capture devices.
>>
>> snd_usb_hw_params() will call Media Controller enable source handler
>> interface to request the media resource. If resource request is granted,
>> it will release it from snd_usb_hw_free(). If resource is busy, -EBUSY is
>> returned.
>>
>> Media specific cleanup is done in usb_audio_disconnect().
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>

Thanks for the review. Fixing them all in the next revision.

-- Shuah
