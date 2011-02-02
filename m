From: "Sebastian H." <vand2@gmx.de>
Subject: Re: alsa-lib TLVs and valgrind
Date: Wed, 02 Feb 2011 14:18:35 +0100
Message-ID: <4D4959AB.1050703@gmx.de>
References: <4D4945FA.4030506@gmx.de> <4D495859.6070101@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 83E911037F9
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 14:23:41 +0100 (CET)
In-Reply-To: <4D495859.6070101@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 02.02.2011 14:12, schrieb Clemens Ladisch:
> Sebastian H. wrote:
>> I'm about to release a new version of alsamixer-qt4
>> (now named qasmixer) and ran the program through valgrind.
>>
>> valgrind --track-origins=yes src/qasmixer &> valgrind.log
>>
>> The log file contains tons of warnings like this
>>
>> ==3432== Conditional jump or move depends on uninitialised value(s)
>> ...
>> ... (qasmixer function calls)
>> ...
>> ==3432==  Uninitialised value was created by a heap allocation
>> ... malloc (vg_replace_malloc.c:236)
>> ... init_db_range (simple_none.c:1111)
>> ... get_dB_range (simple_none.c:1156)
>> ... get_dB_range_ops (simple_none.c:1173)
>> ... snd_mixer_selem_get_playback_dB_range (simple.c:298)
> 
> Valgrind doesn't know about some of the ALSA ioctls.
> Somebody would have to add them to valgrind.

That seems to require quite some effort - also to maintain.
Couldn't just the dB min/max values be initialized with 0 or sth.?

Sebastian
