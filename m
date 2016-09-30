From: David Henningsson <diwic@ubuntu.com>
Subject: Alsa-lib strings?
Date: Fri, 30 Sep 2016 08:39:35 +0200
Message-ID: <3bf2ac97-49f1-8191-94c8-76368b554ab1@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.egensajt.se (smtp.egensajt.se [193.42.159.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 880F9261A5E
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 08:39:40 +0200 (CEST)
Received: from [192.168.5.2] (c83-251-161-62.bredband.comhem.se
 [83.251.161.62])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: diwic@goetyuhd.org)
 by smtp.egensajt.se (Postfix) with ESMTPSA id A16AB186C
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 08:39:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm making some rust bindings for alsa-lib [1] and Rust is quite picky 
about strings; i e, requires them to be UTF-8.

1a) can I count on alsa-lib's strings (everything from card name and 
mixer identifiers to various descriptions) to be UTF-8 or perhaps even 
7-bit? If not, what encoding is to be expected?

1b) In what way can buggy drivers violate the answers to 1a?

2) Can I count on the strings to be zero terminated? E g, I looked at 
snd_ctl_elem_id_set_name 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___control.html#ga813d02a44a9d01a4a2fe81eda7a8670a> 
that sets all 44 characters without ensuring a zero at the last 
character, but snd_ctl_elem_id_get_name 
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___control.html#gaa6cfea3ac963bfdaeb8189e03e927a76> 
does not say anything about a max length, it just gives out a *const 
char. The question applies to all other strings as well.

// David

[1] https://docs.rs/alsa/
