From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Re: Restore state around suspend/resume
Date: Sun, 30 Nov 2008 08:22:49 -0800
Message-ID: <91705d080811300822u6d899fe7pea8ac1f340fee51a__40350.4236405299$1228287895$gmane$org@mail.gmail.com>
References: <91705d080811291240m506b4f7fj54f021411c5bd055@mail.gmail.com>
	<s5h1vwtk2o1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h1vwtk2o1.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: pm-utils <pm-utils@lists.freedesktop.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 30, 2008 at 1:01 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 29 Nov 2008 12:40:02 -0800,
> Dan Nicholson wrote:
>>
>> Hi,
>>
>> Currently, suspending the computer via pm-suspend (as done from HAL),
>> causes the ALSA state to be stored and restored via alsactl. Here's
>> what the hook looks like:
>>
>> http://cgit.freedesktop.org/pm-utils/tree/pm/sleep.d/65alsa
>>
>> Is this still necessary on recent kernels? Is there a list of drivers
>> which properly maintain state across suspend/resume? We're trying to
>> cut down on the amount of work done in userspace which slows down
>> suspend cycles.
>
> The all drivers with PM support should have do store/restore the
> mixer states.  For such drivers, calling alsactl is just a waste of
> time.

Thanks. Which drivers don't have PM support?

> I don't know who introduced it, but maybe it was a workaround...

Yeah, I'm sure it was a workaround, but we're trying to get rid of the
unnecessary ones now.

--
Dan
