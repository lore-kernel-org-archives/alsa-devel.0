From: Manisha Sankpal <manisha.sankpal@gmail.com>
Subject: SALSA library and recording
Date: Wed, 15 Apr 2009 22:02:38 +0530
Message-ID: <5b6fae700904150932x5079088m9b2373cee37053b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D7F9244EE
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 18:32:39 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id b17so2434959rvf.0
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 09:32:38 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi All,
I am using salsa library to capture the data from the sound card.  The
requirement is that the recording should be done from line-in port of the
sound card. The selection of "Line-in" port should be done  programatically.


With ALSA library, I am able to select the line-in by calling
snd_mixer_selem_set_capture_switch_all()  function. However, this function
is returning an error when SALSA library is used.  Is there any other
function/way to select the line-in mixer element in the SALSA API?

The help would be appreciated.
Thanks & regards,
manisha
