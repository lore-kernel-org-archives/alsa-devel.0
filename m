From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Thu, 17 Jun 2010 08:15:36 +0100
Message-ID: <AANLkTimjd_PDBv9agMxqCeMr_Kd1lTuwo2TIwLVRp00U@mail.gmail.com>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
	<hv912l$j53$1@dough.gmane.org>
	<AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>
	<hvbgo6$3fg$1@dough.gmane.org>
	<AANLkTinYBKzxiITOnspsn2QOh_Rdv8FHu_PC7K7cGCXm@mail.gmail.com>
	<4C1951F1.4000504@colin.guthr.ie>
	<AANLkTim8q8dbV5-jyeHev1lh1b8HQOzhEETKBSa4o1Ol@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D87FC103844
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 09:15:36 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id l26so1360780fgb.2
	for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2010 00:15:36 -0700 (PDT)
In-Reply-To: <AANLkTim8q8dbV5-jyeHev1lh1b8HQOzhEETKBSa4o1Ol@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17 June 2010 00:34, Raymond Yau <superquad.vortex2@gmail.com> wrote:
> 2010/6/17 Colin Guthrie <gmane@colin.guthr.ie>
>
>
>>> But this sucks as
>>> the percentage shown in alsa is not the same as the percentage shown in
>>> other GUIs.
>
> alsamixer and amixer 's percentage were not designed as your purpose
>
> Have you studied the source code of alsamixer and amixer
>
> the alsa developers have already posted a lot of time in the mailist list ,
> they prefer to use dB scale instead of percentage
>

That is exactly why percentages are bad. One cannot relate one control
to another if one used percentages.
Say that an  audio card had two controls that adjust the gain of the
audio one after the other.
If I set to to 5% above base_volume and the second 5% below
base_volume, would the output be base_volume???
the first 5% might be +5dB, and the second might be -4dB, one does not know.

Whereas, in dB, if one was set to -5dB, and the other set to +5dB, we
would be sure that the accumulative output would have a gain of 0dB.
Percentages are not nor real units at all, dB are.

Kind Regards

James
