From: David Henningsson <david.henningsson@canonical.com>
Subject: CONFIG_SND_DEBUG (was: Re: [alsa-devel] [PATCH] ALSA: get rid of
 CONFIG_SND_VERBOSE_PRINTK)
Date: Wed, 05 Jun 2013 09:47:30 +0200
Message-ID: <51AEED12.20502@canonical.com>
References: <1370375134.2385.64.camel@joe-AO722>
 <Pine.LNX.4.44L0.1306041646240.1093-100000@iolanthe.rowland.org>
 <s5hobblrt2s.wl%tiwai@suse.de> <1370412921.2385.111.camel@joe-AO722>
 <s5hli6prrsb.wl%tiwai@suse.de> <1370415121.2385.124.camel@joe-AO722>
 <s5hfvwxrqsc.wl%tiwai@suse.de> <1370416077.2385.137.camel@joe-AO722>
 <s5ha9n5rpia.wl%tiwai@suse.de> <1370417670.2385.148.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
In-Reply-To: <1370417670.2385.148.camel@joe-AO722>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Kernel team list <kernel-team@lists.ubuntu.com>, Alan Stern <stern@rowland.harvard.edu>, Andy Whitcroft <apw@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/05/2013 09:34 AM, Joe Perches wrote:
> On Wed, 2013-06-05 at 09:22 +0200, Takashi Iwai wrote:
>> At Wed, 05 Jun 2013 00:07:57 -0700, Joe Perches wrote:
>>> On Wed, 2013-06-05 at 08:54 +0200, Takashi Iwai wrote:
>>>> At Tue, 04 Jun 2013 23:52:01 -0700, Joe Perches wrote:
>>>>> On Wed, 2013-06-05 at 08:32 +0200, Takashi Iwai wrote:
>>>>>> Yes.  These are snd_printd() just to be conditionally built in.
>>>>>> But in most cases it's rather useful to print them (as most distros
>>>>>> set CONFIG_SND_DEBUG=y).
>>>>> Ubuntu doesn't,  I believe Fedora doesn't.
>>>> Then they should have done so :)
>>> But they don't, so what distros do?
>>
>> RedHat (including Fedora) and SUSE do at least.
>
> Mandriva does too.  (still looking around for others)
>
> We can ask Ubuntu to enable CONFIG_SND_DEBUG.
> (cc'd Andy Whitcroft, Leann Ogasawara and David Henningsson)
>
> Maybe there are others Canonical folk that
> should be cc'd?

Adding kernel team mailing list to CC.

Andy/Leann - apparently CONFIG_SND_DEBUG is on by default from upstream, 
and we explicitly disable it. Is there any reason why we do that?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
