From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RFC 00/26] Kill set_fs() in ALSA codes
Date: Wed, 24 May 2017 11:12:02 +0900
Message-ID: <462afc4d-8b74-f770-4fb3-5b9a406bc224@sakamocchi.jp>
References: <20170511210925.18208-1-tiwai@suse.de>
 <e0af170c-8a8b-254a-e4fc-1bca373938ae@sakamocchi.jp>
 <s5hwp9ibk7u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id AF643266B78
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 04:12:05 +0200 (CEST)
In-Reply-To: <s5hwp9ibk7u.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 15 2017 17:25, Takashi Iwai wrote:
> I don't understand yet clearly how your proxy driver is supposed to
> work.  But at this moment, the higher priority is to get rid of
> set_fs() in the time frame for 4.13 kernel.  For that purpose, my
> approach is rather straightforward.  There is no big code flow change,
> and all changes can be applied gradually, and less risk of
> regressions.
> 
> I don't object against the redesign of the PCM transfer if it really
> works better.  But please let the code speaks.

This is it.
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120984.html


Regards

Takashi Sakamoto
