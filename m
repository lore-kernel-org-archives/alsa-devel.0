From: Laura Abbott <labbott@redhat.com>
Subject: Regression with a91d66129fb9 ("ALSA: hda - Fix incorrect TLV callback
 check introduced during set_fs() removal")
Date: Tue, 21 Nov 2017 08:14:42 -0800
Message-ID: <06c676da-d53b-ff92-f147-c6aa2a56e889@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, PaX Team <pageexec@freemail.hu>
List-Id: alsa-devel@alsa-project.org

Hi,

Fedora got a bug report (https://bugzilla.redhat.com/show_bug.cgi?id=1512853)
that Line Out stopped working between 4.13.9 and 4.13.10. Reverting
82d745a55779 ("ALSA: hda - Fix incorrect TLV callback check introduced during set_fs() removal")
fixed the problem. I didn't ask the reporter to test on 4.14 since I didn't see
anything explicitly tagged as fixing the issue. Any ideas?

Thanks,
Laura
