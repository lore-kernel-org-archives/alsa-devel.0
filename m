From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Fundamental principle of audio mixing?
Date: Mon, 24 Sep 2007 08:49:39 -0300
Message-ID: <5f52f6d70709240449x580d1142l4946fee3dec5bbf7@mail.gmail.com>
References: <8d6898730709240031q4f8a39a1m577ef7cbc114f34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 45E5210383E
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 13:49:41 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so1185153rvb
	for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2007 04:49:39 -0700 (PDT)
In-Reply-To: <8d6898730709240031q4f8a39a1m577ef7cbc114f34@mail.gmail.com>
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
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 9/24/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:

> Can any body throw some lights on how audio mixing is done in
> software? Basic principle?

Basically you add the PCM samples (if they are at the same resolution
and sampling rate) and renormalize if needed. The sampling rate
conversion can be tricky tho.
