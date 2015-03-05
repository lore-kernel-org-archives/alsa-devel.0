From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: Add a NULL pointer check
 in asoc_simple_card_dai_link_of
Date: Thu, 05 Mar 2015 13:03:32 +0100
Message-ID: <54F84614.3020108@metafoo.de>
References: <20150303132900.GA22246@vishal> <54F76B43.3030602@bfs.de> <CAC3a_SDWqGLsgUu8_mRYkW=Y+KHvWvAWjUYr4Ba3BrDBiP6nNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAC3a_SDWqGLsgUu8_mRYkW=Y+KHvWvAWjUYr4Ba3BrDBiP6nNA@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: vishal.thanki@gmail.com, wharms@bfs.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/05/2015 11:45 AM, Vishal Thanki wrote:
> I am new to kasprintf. I think we need to make sure of freeing memory
> allocated using kasprintf.

There is also devm_kasprintf().

But these are really two separate things. One thing is the missing NULL 
check, which is a bug fix and is fixed by your patch. The other thing is the 
conversion to kasprintf() which is a code cleanup and should be done in a 
separate patch.

- Lars

