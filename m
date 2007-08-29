From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/4] 2.6.23-rc4: known regressions
Date: Wed, 29 Aug 2007 17:27:14 +0200
Message-ID: <46D59052.6040609@googlemail.com>
References: <46D58CC6.4020605@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46D58CC6.4020605@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Michael Sedkowski <sedmich@gmail.com>, Alexey Dobriyan <adobriyan@sw.ru>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, "Ivan N. Zlatev" <contact@i-nz.net>, Thomas Meyer <thomas@m3y3r.de>, dth <dth@dth.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

Here is a list of some known regressions in 2.6.23-rc4.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            9
Andi Kleen                             5
Linus Torvalds                         5
Andrew Morton                          4
Hugh Dickins                           4
Al Viro                                3
Alan Stern                             3
Cornelia Huck                          3
Jens Axboe                             3
Tejun Heo                              3



ACPI

Subject         : 2.6.23-rc4: maxcpus still broken
References      : http://lkml.org/lkml/2007/8/28/87
Last known good : ?
Submitter       : Alexey Dobriyan <adobriyan@sw.ru>
Caused-By       : Len Brown <len.brown@intel.com>
                  commit 61ec7567db103d537329b0db9a887db570431ff4
Handled-By      : Len Brown <len.brown@intel.com>
Status          : problem is being debugged

Subject         : MCFG bug on hp nx6310
References      : http://lkml.org/lkml/2007/8/8/252
Last known good : ?
Submitter       : Michael Sedkowski <sedmich@gmail.com>
Caused-By       : ?
Handled-By      : ?
Status          : unknown

Subject         : 2.6.23-rc1-git10 hangs on boot - needs "acpi=off"
References      : http://lkml.org/lkml/2007/8/2/24
Last known good : ?
Submitter       : Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
Caused-By       : ?
Handled-By      : Len Brown <len.brown@intel.com>
Status          : problem is being debugged



ALSA

Subject         : Master volume control broken
References      : http://lkml.org/lkml/2007/8/18/46
Last known good : ?
Submitter       : Thomas Meyer <thomas@m3y3r.de>
Caused-By       : Ivan N. Zlatev <contact@i-nz.net>
                  commit 5d5d3bc3eddf2ad97b2cb090b92580e7fed6cee1
Handled-By      : Ivan N. Zlatev <contact@i-nz.net>
Status          : problem is being debugged



CPUFREQ

Subject         : ide problems: 2.6.22-git17 working, 2.6.23-rc1* is not
References      : http://lkml.org/lkml/2007/7/27/298
                  http://lkml.org/lkml/2007/7/29/371
Last known good : ?
Submitter       : dth <dth@dth.net>
Caused-By       : Len Brown <lenb@kernel.org>
                  commit f79e3185dd0f8650022518d7624c876d8929061b
Handled-By      : Len Brown <lenb@kernel.org>
Status          : problem is being debugged



Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
